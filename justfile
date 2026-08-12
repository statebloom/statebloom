# Run the test suite.
#
# Guarded: this repository has no test files yet. Vitest exits 1 on "no test
# files found", which would keep the pre-push gate permanently red for a repo
# that legitimately has nothing to test. Delete the guard (and add vitest to
# devDependencies) when the first test lands.
test:
    #!/usr/bin/env sh
    if [ -z "$(find . -path ./node_modules -prune -o \( -name '*.test.*' -o -name '*.spec.*' \) -print 2>/dev/null | head -n 1)" ]; then
        echo "No test files in the tree yet; skipping. Remove this guard in the justfile when the first test lands."
        exit 0
    fi
    npx vitest run

# Run lint checks
lint:
    npx eslint .

# Format the codebase
format:
    npx prettier --write .

# Check formatting without modifying files
fmt-check:
    npx prettier --check .

# Run type checks.
#
# Guarded: there is no TypeScript and no tsconfig.json in this repository yet,
# and `tsc --noEmit` errors with TS18003 ("no inputs were found") rather than
# passing trivially. Delete the guard (and add typescript to devDependencies)
# when the framework packages land here.
typecheck:
    #!/usr/bin/env sh
    if [ ! -f tsconfig.json ]; then
        echo "No tsconfig.json yet; skipping type check. Remove this guard in the justfile when TypeScript lands."
        exit 0
    fi
    npx tsc --noEmit

# Fast static checks for the pre-commit hook (no type check, no tests)
check-fast: lint fmt-check

# Run the standard local verification set (also runs in the pre-push hook).
# A successful run credits the pre-push stamp too, so a manual `just check`
# right before pushing skips a redundant rerun in the hook.
check: check-fast typecheck test
    [ -f .raven/git-hooks/lib/with-verified-cache.sh ] && sh .raven/git-hooks/lib/with-verified-cache.sh check true || true

# Report known advisories in this project's dependency manifests.
#
# Deliberately NOT a dependency of `check`. Every other recipe here is a
# function of the working tree; an audit is a function of the tree AND of what
# the world published overnight, so as a gate it would turn an unchanged commit
# red for reasons no one can fix in that commit. A gate is also binary, while an
# advisory has to be classified first -- see the Advisory Triage section of the
# `raven-dependency-update` skill. Report-only: never fails the shell.
audit:
    #!/usr/bin/env sh
    if ! command -v osv-scanner >/dev/null 2>&1; then
        echo "osv-scanner is not installed; skipping the dependency audit."
        echo "Install: https://google.github.io/osv-scanner/installation/"
        exit 0
    fi
    osv-scanner scan source -r .
    status=$?
    # Documented exit codes: 0 clean, 1-126 result-related (findings),
    # 127 general error, 128 nothing scannable, 129-255 other errors.
    if [ "$status" -eq 0 ]; then
        echo "No known advisories in the scanned manifests."
    elif [ "$status" -ge 1 ] && [ "$status" -le 126 ]; then
        echo "Advisories reported above. Classify each one before remediating"
        echo "(see the raven-dependency-update skill); this is not a gate."
    elif [ "$status" -eq 128 ]; then
        echo "No supported dependency manifest found; nothing to audit."
    else
        echo "osv-scanner exited $status without completing the scan." >&2
    fi
    exit 0

# Install pre-commit (fast checks) and pre-push (full check) git hooks
install-hooks:
    #!/usr/bin/env sh
    # Resolve Git's effective hooks dir (honors core.hooksPath and linked
    # worktrees) so hooks land where Git will run them, not a hard-coded
    # .git/hooks that a custom hooksPath would ignore.
    hooks_dir=$(git rev-parse --git-path hooks) || exit 1
    install_hook() {
        name="$1"
        cmd="$2"
        path="$hooks_dir/$name"
        if [ -f "$path" ]; then
            echo "A $name hook already exists at $path."
            echo "To use RAVEN's gate, add this line to it:"
            printf "  %s\n" "$cmd"
        else
            mkdir -p "$hooks_dir"
            printf '#!/bin/sh\n%s\n' "$cmd" > "$path"
            chmod +x "$path"
            echo "Installed $path to run '$cmd'."
        fi
    }
    install_hook pre-commit "just check-fast"
    install_hook pre-push "just check"

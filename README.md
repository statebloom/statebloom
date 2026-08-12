# StateBloom

A local-first, standards-based frontend runtime and component library built on owned custom
elements, `lit-html`, and signals.

> **Status: pre-release, nothing published yet.** This repository currently holds only a name
> placeholder. The framework is being developed elsewhere and will be extracted into this
> repository ahead of its first public release.

## Packages

Everything functional will be published under the `@statebloom` scope:

| Package                  | Purpose                              |
| ------------------------ | ------------------------------------ |
| `@statebloom/core`       | Core primitives                      |
| `@statebloom/runtime`    | Element runtime and view definitions |
| `@statebloom/ui`         | Component catalog                    |
| `@statebloom/kernel`     | Intent and state kernel              |
| `@statebloom/router`     | Routing                              |
| `@statebloom/projection` | Projections                          |
| `@statebloom/observe`    | Observability                        |
| `@statebloom/devtools`   | Developer tooling                    |
| `@statebloom/testing`    | Testing kit                          |
| `@statebloom/vite-hmr`   | Vite HMR integration                 |

The unscoped [`statebloom`](packages/statebloom) package is a placeholder only — there is nothing
to import from it.

## Layout

```
packages/
  statebloom/     name placeholder (published)
  <package>/      directory name matches its published npm name
site/             documentation site
examples/         runnable examples
```

## License

[Apache License 2.0](LICENSE).

Chosen over MIT deliberately, for two clauses MIT does not have: §3 grants an express patent licence
with a retaliation term, and §6 explicitly withholds trademark rights in the StateBloom name. Both
matter more for a project with a name to defend than the extra length costs in familiarity. Note
that Apache-2.0 is compatible with GPLv3 but **not** GPLv2.

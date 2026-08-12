# Contributing to StateBloom

StateBloom is pre-release and its packages are not published yet, so external contributions are not
being solicited at this stage. This document exists so that the terms are settled before the first
one arrives rather than after.

## Licensing of contributions

StateBloom is licensed under the [Apache License 2.0](LICENSE). Contributions are accepted under the
same license — Apache-2.0 §5 already provides that anything you intentionally submit for inclusion
is licensed under those terms unless you explicitly state otherwise.

**You keep the copyright in your contribution.** There is no contributor licence agreement to sign
and no copyright assignment. What we ask instead is a sign-off, below.

A consequence worth stating plainly, since it is the practical difference between this approach and
a CLA: because the project only ever receives an Apache-2.0 licence from you, the project **cannot
relicense your contribution** without your agreement. That is deliberate.

## Developer Certificate of Origin

Every commit must carry a `Signed-off-by` line certifying the DCO below. Git adds it for you:

```
git commit -s -m "your message"
```

which appends:

```
Signed-off-by: Your Name <your.email@example.com>
```

Use your real name and an address you can be reached at. The sign-off is a statement you are making,
so it must match a real identity.

To sign off a commit you already made: `git commit --amend -s --no-edit`.

### Developer Certificate of Origin 1.1

```
Developer Certificate of Origin
Version 1.1

Copyright (C) 2004, 2006 The Linux Foundation and its contributors.

Everyone is permitted to copy and distribute verbatim copies of this
license document, but changing it is not allowed.


Developer's Certificate of Origin 1.1

By making a contribution to this project, I certify that:

(a) The contribution was created in whole or in part by me and I
    have the right to submit it under the open source license
    indicated in the file; or

(b) The contribution is based upon previous work that, to the best
    of my knowledge, is covered under an appropriate open source
    license and I have the right under that license to submit that
    work with modifications, whether created in whole or in part
    by me, under the same open source license (unless I am
    permitted to submit under a different license), as indicated
    in the file; or

(c) The contribution was provided directly to me by some other
    person who certified (a), (b) or (c) and I have not modified
    it.

(d) I understand and agree that this project and the contribution
    are public and that a record of the contribution (including all
    personal information I submit with it, including my sign-off) is
    maintained indefinitely and may be redistributed consistent with
    this project or the open source license(s) involved.
```

## Trademarks

Apache-2.0 §6 does not grant rights in the StateBloom name or marks. You are free to use, modify,
and redistribute the code, including in commercial and proprietary products; naming your derivative
"StateBloom" or implying endorsement is a separate matter and is not granted here.

## Before you open a pull request

The build contract is the `justfile`, and it works on a bare clone with no agent tooling installed:

```
pnpm install --frozen-lockfile
just check
```

`just check` runs lint, formatting, type checks, and tests. Please make sure it passes. Install the
git hooks that run it automatically with `just install-hooks`.

## Conventions

Repository conventions live in [AGENTS.md](AGENTS.md), which applies to human and automated
contributors alike.

# DarwinX Kernel

DarwinX begins with upstream XNU rather than a fork containing immediate feature changes.

## Directories

- `config/` — DarwinX-owned build/target configuration.
- `patches/` — reviewed DarwinX changes applied to a pinned upstream XNU revision.

## Patch requirements

Every kernel patch must document:
1. upstream XNU commit SHA;
2. problem being solved;
3. affected architecture/platform;
4. expected behavior;
5. build and test procedure;
6. rollback/revert procedure.

Milestone 0 should require no functional XNU patch unless a documented build-environment compatibility fix is unavoidable.

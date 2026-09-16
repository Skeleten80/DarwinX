# DarwinX Tools

Project-owned engineering tooling belongs here.

Planned areas:
- `build/` — environment checks and reproducible build orchestration;
- `source/` — upstream acquisition and revision verification;
- `image/` — controlled test/root image construction;
- `debug/` — log collection, symbol handling and debugger helpers.

Scripts should fail loudly when prerequisites or pinned revisions do not match expectations.

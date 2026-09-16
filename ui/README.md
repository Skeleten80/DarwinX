# DarwinX UI

This area will contain DarwinX's graphical environment after the kernel/userspace baseline is stable.

Planned separation:
- `compositor/` — display server/compositing and rendering backends;
- `shell/` — desktop/system shell and window-management policy;
- `toolkit/` — native controls, layout, input, accessibility-facing abstractions and application UI primitives.

The first graphics milestone should include a reference/software path so UI architecture can be tested independently of hardware GPU enablement.

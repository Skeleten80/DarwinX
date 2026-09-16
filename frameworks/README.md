# DarwinX Frameworks

DarwinX frameworks provide project-owned higher-level APIs above the Darwin runtime and system services.

Initial architectural domains:
- Core — fundamental types, errors, time, data and common services;
- Runtime — process/service abstractions and low-level Darwin integration;
- Graphics — display-independent graphics primitives and rendering interfaces;
- Application — later application lifecycle and UI-facing services.

These APIs are DarwinX designs. They should not depend on reproducing proprietary Apple framework implementations.

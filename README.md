# DarwinX

DarwinX is an experimental operating-system project built around the open-source Darwin/XNU ecosystem.

The goal is to create a reliable, understandable, general-purpose Darwin-based operating system while keeping upstream Apple open-source components clearly separated from DarwinX-owned platform code.

> DarwinX is an independent research project and is not affiliated with or endorsed by Apple Inc.

## Project goals

1. Establish a reproducible XNU development build and test environment.
2. Assemble a minimal Darwin userspace.
3. Build system services and a stable DarwinX platform layer.
4. Design DarwinX Core APIs and frameworks.
5. Build a graphics/compositor stack and native UI toolkit.
6. Add hardware support incrementally, treating each Apple hardware family as an explicit platform target.
7. Keep kernel modifications minimal until the upstream baseline is reproducible and understood.

## Architecture

```text
Applications
    |
DarwinX UI / Application Frameworks
    |
DarwinX Core Frameworks
    |
System Services
    |
Darwin Userspace Runtime
    |
XNU
  |- Mach
  |- BSD
  |- IOKit
  `- Security
    |
Platform / Hardware Support
```

See `docs/ARCHITECTURE.md` and `docs/ROADMAP.md`.

## Current milestone

**Milestone 0 — Reproducible XNU baseline**

Before developing a desktop, frameworks, or substantial kernel changes, DarwinX will establish documented build requirements, pinned upstream revisions, repeatable source acquisition, a repeatable XNU build, a controlled boot/test target, debugging/logging, and recovery procedures.

## Repository layout

```text
docs/          Architecture, boot, kernel and roadmap documentation
external/      Upstream dependency metadata and acquisition tooling
kernel/        DarwinX kernel configuration and patches
system/        DarwinX userspace services
frameworks/    DarwinX core/application frameworks
ui/            Compositor, shell and UI toolkit
sdk/           Public headers, libraries and developer tooling
tools/         Build, image and debugging tools
tests/         Kernel, userspace and framework tests
```

## Scope distinction

Darwin and XNU are not the complete macOS operating system. Many Apple frameworks, graphical components, drivers, firmware and applications are not part of the open-source Darwin/XNU releases. DarwinX therefore uses the open-source components as a foundation and implements its own higher-level platform where required.

## Status

Early research and bootstrap stage. Do not use DarwinX for production or safety-critical systems.

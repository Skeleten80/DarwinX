# DarwinX Engineering Roadmap

## Milestone 0 — Reproducible XNU baseline

Goal: prove that the project can acquire, build, inspect and debug a known XNU source baseline.

Exit criteria:
- upstream revisions are recorded;
- source acquisition is repeatable;
- build host requirements are documented;
- XNU headers and kernel can be built for the selected development target;
- build artifacts are identifiable and reproducible enough for development;
- boot/test environment and logging path are documented;
- no DarwinX kernel feature work is required to pass this milestone.

## Milestone 1 — Minimal Darwin userspace

Bring up the minimum runtime and command environment required to inspect and operate the system. Establish process launch, basic filesystem access, logging and diagnostic utilities.

## Milestone 2 — System services

Introduce DarwinX service management, configuration, networking/storage services, IPC conventions, permissions and structured logging.

## Milestone 3 — DarwinX SDK and Core

Define supported public APIs, headers, ABI policy, package/build conventions and initial Core/Runtime frameworks. Add unit and integration tests.

## Milestone 4 — Graphics foundation

Prototype display service, compositor, input routing and a software/reference rendering path before hardware acceleration becomes mandatory.

## Milestone 5 — DarwinX UI

Build window management, UI toolkit, shell/desktop and first-party diagnostic applications.

## Milestone 6 — Hardware enablement

Expand from the controlled reference target to explicitly supported Apple hardware families. Each target receives a hardware-support matrix covering boot, CPU/SMP, memory, timers, interrupts, storage, USB, networking, input, display/GPU, audio, power management and sleep/wake.

## Milestone 7 — Reliability and developer platform

Harden update/recovery mechanisms, testing, crash diagnostics, SDK tooling, documentation, CI and release engineering.

## Rule for progression

Do not advance a subsystem merely because code exists. Each milestone requires a repeatable test proving the previous layer works.

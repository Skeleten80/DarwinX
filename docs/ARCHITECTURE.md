# DarwinX Architecture

## Design objective

DarwinX is a new operating-system distribution built on open-source Darwin/XNU components. It is not an attempt to reconstruct macOS. DarwinX-owned components sit above and around upstream code through explicit interfaces.

## Layer model

```text
+---------------------------------------+
| Applications                          |
+---------------------------------------+
| DarwinX UI + Application Frameworks   |
+---------------------------------------+
| DarwinX Core Frameworks               |
+---------------------------------------+
| DarwinX System Services               |
+---------------------------------------+
| Darwin Runtime / POSIX / Mach APIs    |
+---------------------------------------+
| XNU: Mach + BSD + IOKit + Security    |
+---------------------------------------+
| Platform / Drivers / Boot Environment |
+---------------------------------------+
| Hardware                              |
+---------------------------------------+
```

## Kernel policy

The first kernel baseline remains as close as practical to upstream XNU. DarwinX-specific changes belong in `kernel/patches/` and must include a rationale, upstream source revision, test procedure, and rollback path.

## Userspace

The first userspace should be deliberately small: runtime libraries, init/service management, shell/debug utilities, filesystem tooling, networking essentials and logging. Higher-level frameworks are introduced only after this baseline is testable.

## Framework strategy

DarwinX frameworks are independent APIs rather than copies of proprietary Apple frameworks. Initial framework domains are Core, Runtime, Graphics and Foundation-like general services. Public API stability begins only after an experimental incubation period.

## Graphics strategy

Graphics is a later milestone. The architecture separates the display/compositor server, rendering backend, input routing, window management and UI toolkit so hardware-specific rendering work does not leak through application APIs.

## Hardware strategy

There is no single generic "Apple device" target. DarwinX tracks platform support explicitly by architecture and hardware family. Initial development uses a controlled target before attempting broader physical Apple hardware support.

## Security principles

- no dependency on jailbreaks, kernel exploits or secure-boot bypasses;
- least-privilege userspace services;
- explicit trust boundaries;
- memory-safe implementation languages where practical outside kernel/ABI constraints;
- reproducible dependency provenance;
- fuzzing and negative testing for parsers and privileged interfaces.

## Source ownership

`external/` describes or acquires upstream sources. DarwinX-owned source belongs elsewhere. This separation keeps licensing, provenance and future upstream synchronization understandable.

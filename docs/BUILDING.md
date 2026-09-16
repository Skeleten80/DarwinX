# Building DarwinX — Milestone 0

Milestone 0 is intentionally narrow: reproduce an upstream XNU development build before DarwinX changes the kernel.

## Baseline

DarwinX currently records the Apple macOS 26.0 open-source release as its research baseline.

- distribution-macOS commit: `4e290a9b9d3723c65d2a606223d41eb90ecdbf99`
- XNU tag: `xnu-12377.1.9`
- XNU commit: `f6217f891ac0bb64f3d375211650a4c1ff8ca1ea`

See `external/baselines/macos-26.0.json`.

## Why the kernel is pinned

DarwinX must be reproducible. A moving branch such as `main` is unsuitable as a build input because upstream changes can silently change the source between two builds. The acquisition script therefore checks out an immutable commit and verifies that the recorded Apple release tag resolves to it.

## Host strategy

The first build path targets a macOS development host with Apple's command-line developer environment and a macOS SDK. This is a build-host decision, not a claim that DarwinX itself requires macOS once it is mature.

The basic preflight currently checks for:

- Git
- Make
- Clang
- `xcrun`
- Python 3
- a discoverable macOS SDK

XNU source drops can have additional release-specific dependencies. We will discover, document and automate those rather than hiding them in undocumented local setup.

## Workflow

From the DarwinX repository root:

```sh
chmod +x tools/source/fetch-xnu.sh tools/build/check-host.sh tools/build/build-xnu.sh
./tools/source/fetch-xnu.sh
./tools/build/check-host.sh
./tools/build/build-xnu.sh
```

To request an architecture explicitly:

```sh
ARCH_CONFIG=ARM64 ./tools/build/build-xnu.sh
```

or:

```sh
ARCH_CONFIG=X86_64 ./tools/build/build-xnu.sh
```

The default kernel configuration is `DEVELOPMENT`. Override it only when needed:

```sh
KERNEL_CONFIG=DEBUG ./tools/build/build-xnu.sh
```

Additional arguments are forwarded to Make, for example:

```sh
./tools/build/build-xnu.sh -j8
```

## Expected failures are useful

A failed first build is not grounds for patching XNU immediately. Capture the first deterministic failure, identify the missing public dependency/tool/header, and add that prerequisite to the DarwinX bootstrap process. This gives us a documented dependency closure instead of an unrepeatable developer machine.

## Milestone 0 completion criteria

Milestone 0 is complete only when we can:

1. acquire the exact recorded source;
2. verify its identity;
3. reproduce the build environment;
4. build an unmodified XNU `DEVELOPMENT` kernel;
5. retain symbols and build logs;
6. repeat the procedure on a clean development environment;
7. document a controlled boot/debug target.

Only after this baseline is stable should DarwinX begin carrying kernel patches.

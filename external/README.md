# DarwinX Upstream Sources

DarwinX uses selected projects from Apple's public `apple-oss-distributions` repositories. Do not assume that cloning every Apple OSS repository produces a complete macOS or a directly bootable DarwinX system.

## Initial dependency groups

### Kernel baseline
- `apple-oss-distributions/xnu`

### Runtime / process foundation
- `apple-oss-distributions/Libc`
- `apple-oss-distributions/Libsystem`
- `apple-oss-distributions/libplatform`
- `apple-oss-distributions/libpthread`
- `apple-oss-distributions/libmalloc`
- `apple-oss-distributions/dyld`
- `apple-oss-distributions/libdispatch`
- `apple-oss-distributions/libclosure`
- `apple-oss-distributions/objc4` where required by DarwinX userspace/framework experiments

### I/O and system integration candidates
- `apple-oss-distributions/IOKitUser`
- `apple-oss-distributions/IOKitTools`
- `apple-oss-distributions/DiskArbitration`
- `apple-oss-distributions/system_config`
- `apple-oss-distributions/Libnotify`

### Bootstrap and command environment candidates
- `apple-oss-distributions/launchd`
- `apple-oss-distributions/bootstrap_cmds`
- `apple-oss-distributions/system_cmds`
- `apple-oss-distributions/shell_cmds`
- `apple-oss-distributions/file_cmds`
- `apple-oss-distributions/network_cmds`

### Build metadata/tooling candidates
- `apple-oss-distributions/CoreOSMakefiles`
- `apple-oss-distributions/AvailabilityVersions`

Not every candidate will be required for the first bootable baseline. Dependencies move into the active set only after their role and compatible revision are established.

## Version policy

Do not blindly track each project's `main` branch independently. Apple publishes aggregate distribution repositories whose submodule revisions provide useful compatibility/provenance information. DarwinX should record a chosen distribution baseline and pin each consumed component to an exact commit SHA.

A future `manifest.lock` will be the machine-readable source of truth. It should contain repository URL, commit SHA, license/provenance notes and DarwinX dependency group.

## Source layout

Upstream source checkouts are not intended to be committed wholesale into the DarwinX repository. Acquisition tooling will place them under a local working directory such as `external/src/`, which should remain ignored by Git. DarwinX patches remain versioned under `kernel/patches/` or the owning DarwinX subsystem.

## Licensing

Each upstream project retains its own license and notices. Never remove upstream copyright or license files. DarwinX-owned code should have a separately documented project license before redistribution expands.

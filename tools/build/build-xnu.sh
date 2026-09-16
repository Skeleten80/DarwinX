#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
XNU_DIR="${DARWINX_EXTERNAL_DIR:-${ROOT_DIR}/external/src}/xnu"
EXPECTED_COMMIT="f6217f891ac0bb64f3d375211650a4c1ff8ca1ea"
KERNEL_CONFIG="${KERNEL_CONFIG:-DEVELOPMENT}"
ARCH_CONFIG="${ARCH_CONFIG:-}"

if [[ ! -d "${XNU_DIR}/.git" ]]; then
  echo "error: pinned XNU source not found at ${XNU_DIR}" >&2
  echo "run tools/source/fetch-xnu.sh first" >&2
  exit 1
fi

ACTUAL_COMMIT="$(git -C "${XNU_DIR}" rev-parse HEAD)"
if [[ "${ACTUAL_COMMIT}" != "${EXPECTED_COMMIT}" ]]; then
  echo "error: refusing to build an unpinned XNU revision" >&2
  echo "expected: ${EXPECTED_COMMIT}" >&2
  echo "actual:   ${ACTUAL_COMMIT}" >&2
  exit 1
fi

"${ROOT_DIR}/tools/build/check-host.sh"

SDKROOT="${SDKROOT:-$(xcrun --sdk macosx --show-sdk-path)}"

args=("SDKROOT=${SDKROOT}" "KERNEL_CONFIGS=${KERNEL_CONFIG}")
if [[ -n "${ARCH_CONFIG}" ]]; then
  args+=("ARCH_CONFIGS=${ARCH_CONFIG}")
fi

printf '==> XNU commit: %s\n' "${ACTUAL_COMMIT}"
printf '==> SDKROOT: %s\n' "${SDKROOT}"
printf '==> Kernel configuration: %s\n' "${KERNEL_CONFIG}"
if [[ -n "${ARCH_CONFIG}" ]]; then
  printf '==> Architecture: %s\n' "${ARCH_CONFIG}"
else
  echo "==> Architecture: XNU host default"
fi

echo "==> Starting upstream XNU build"
make -C "${XNU_DIR}" "${args[@]}" "$@"

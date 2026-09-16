#!/usr/bin/env bash
set -euo pipefail

fail=0

check() {
  if command -v "$1" >/dev/null 2>&1; then
    printf '%-12s %s\n' "$1" "OK ($(command -v "$1"))"
  else
    printf '%-12s %s\n' "$1" "MISSING"
    fail=1
  fi
}

echo "DarwinX Milestone 0 host preflight"
echo "-----------------------------------"
uname -a
printf '\nRequired tools:\n'
check git
check make
check clang
check xcrun
check python3

if command -v xcrun >/dev/null 2>&1; then
  printf '\nApple developer environment:\n'
  xcrun --find clang || fail=1
  SDK_PATH="$(xcrun --sdk macosx --show-sdk-path 2>/dev/null || true)"
  if [[ -n "${SDK_PATH}" ]]; then
    echo "macOS SDK: ${SDK_PATH}"
  else
    echo "macOS SDK: NOT FOUND"
    fail=1
  fi
fi

printf '\n'
if [[ ${fail} -ne 0 ]]; then
  echo "Preflight failed. Install/configure the missing build prerequisites before compiling XNU."
  exit 1
fi

echo "Preflight passed for the basic DarwinX XNU build environment."
echo "Note: passing this check does not guarantee that every dependency required by this XNU source drop is present."

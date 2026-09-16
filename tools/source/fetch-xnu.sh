#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
DEST="${DARWINX_EXTERNAL_DIR:-${ROOT_DIR}/external/src}/xnu"
REPO="https://github.com/apple-oss-distributions/xnu.git"
TAG="xnu-12377.1.9"
EXPECTED_COMMIT="f6217f891ac0bb64f3d375211650a4c1ff8ca1ea"

command -v git >/dev/null 2>&1 || { echo "error: git is required" >&2; exit 1; }

if [[ -e "${DEST}" && ! -d "${DEST}/.git" ]]; then
  echo "error: ${DEST} exists but is not a Git repository" >&2
  exit 1
fi

mkdir -p "$(dirname "${DEST}")"

if [[ ! -d "${DEST}/.git" ]]; then
  echo "==> Cloning Apple XNU"
  git clone --filter=blob:none --no-checkout "${REPO}" "${DEST}"
fi

cd "${DEST}"
echo "==> Fetching pinned DarwinX baseline ${TAG}"
git fetch --force --tags origin "${TAG}"
git checkout --detach "${EXPECTED_COMMIT}"

ACTUAL_COMMIT="$(git rev-parse HEAD)"
if [[ "${ACTUAL_COMMIT}" != "${EXPECTED_COMMIT}" ]]; then
  echo "error: XNU commit mismatch" >&2
  echo "expected: ${EXPECTED_COMMIT}" >&2
  echo "actual:   ${ACTUAL_COMMIT}" >&2
  exit 1
fi

TAG_COMMIT="$(git rev-list -n 1 "${TAG}")"
if [[ "${TAG_COMMIT}" != "${EXPECTED_COMMIT}" ]]; then
  echo "error: ${TAG} no longer resolves to the recorded commit" >&2
  exit 1
fi

echo "==> Verified XNU ${TAG} @ ${ACTUAL_COMMIT}"
echo "==> Source ready at ${DEST}"

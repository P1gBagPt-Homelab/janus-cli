#!/usr/bin/env bash
# ==============================================================================
# Debian Package (.deb) Builder for Janus CLI
# Outputs: dist/janus_<version>_all.deb
# ==============================================================================

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(cd "${SCRIPT_DIR}/.." && pwd)"

VERSION="${1:-1.2.1}"
PKG_NAME="janus-cli"
BUILD_DIR="${ROOT_DIR}/build/${PKG_NAME}_${VERSION}_all"
DIST_DIR="${ROOT_DIR}/dist"

echo "Building Debian package: ${PKG_NAME} v${VERSION}..."

rm -rf "${ROOT_DIR}/build" "${DIST_DIR}"
mkdir -p "${BUILD_DIR}/DEBIAN"
mkdir -p "${BUILD_DIR}/usr/local/bin"
mkdir -p "${BUILD_DIR}/etc/bash_completion.d"
mkdir -p "${BUILD_DIR}/etc/janus"
mkdir -p "${DIST_DIR}"

# 1. Create DEBIAN/control file
cat << EOF > "${BUILD_DIR}/DEBIAN/control"
Package: ${PKG_NAME}
Version: ${VERSION}
Section: admin
Priority: optional
Architecture: all
Maintainer: P1gBagPt <https://github.com/P1gBagPt-Homelab>
Depends: bash (>= 4.0)
Suggests: docker.io, lm-sensors, smartmontools
Description: Unified CLI management tool for hybrid gaming and dual-boot home servers.
 Control hardware telemetry, NVIDIA GPU VRAM, Docker containers, automated
 backups, and 1-click dual-boot switching to Windows Gaming Rig.
EOF

# 2. Copy Executable, Completion, and Example Config
cp "${ROOT_DIR}/bin/janus" "${BUILD_DIR}/usr/local/bin/janus"
chmod 755 "${BUILD_DIR}/usr/local/bin/janus"

cp "${ROOT_DIR}/completions/janus.bash" "${BUILD_DIR}/etc/bash_completion.d/janus"
chmod 644 "${BUILD_DIR}/etc/bash_completion.d/janus"

cp "${ROOT_DIR}/etc/janus.conf.example" "${BUILD_DIR}/etc/janus/janus.conf.example"
chmod 644 "${BUILD_DIR}/etc/janus/janus.conf.example"

# 3. Build .deb package
if command -v dpkg-deb >/dev/null 2>&1; then
    dpkg-deb --build --root-owner-group "${BUILD_DIR}" "${DIST_DIR}/${PKG_NAME}_${VERSION}_all.deb"
    echo "✓ Built Debian package: ${DIST_DIR}/${PKG_NAME}_${VERSION}_all.deb"
else
    echo "Notice: dpkg-deb not installed on this machine. Package tree staged at ${BUILD_DIR}"
fi

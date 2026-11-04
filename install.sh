#!/usr/bin/env bash
# ==============================================================================
# Universal Installer for Janus CLI
# Supports:
#   1. Local execution: sudo bash install.sh
#   2. Remote one-liner: curl -fsSL https://raw.githubusercontent.com/P1gBagPt-Homelab/janus-cli/main/install.sh | sudo bash
# ==============================================================================

set -euo pipefail

REPO_RAW_URL="https://raw.githubusercontent.com/P1gBagPt-Homelab/janus-cli/main"
TARGET_BIN="/usr/local/bin/janus"
TARGET_COMPLETION="/etc/bash_completion.d/janus"
TARGET_CONFIG_DIR="/etc/janus"

# Check root / sudo
if [[ $EUID -ne 0 ]]; then
   echo "Error: This installer requires root privileges. Please run with sudo:"
   echo "  sudo bash install.sh"
   exit 1
fi

echo "=================================================="
echo " Installing Janus CLI (Dual-Boot & Homelab Manager)"
echo "=================================================="

mkdir -p "$TARGET_CONFIG_DIR"
mkdir -p /etc/bash_completion.d

# Determine if running locally from cloned repo or remotely via pipe
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" 2>/dev/null && pwd || echo "")"

if [[ -n "$SCRIPT_DIR" && -f "${SCRIPT_DIR}/bin/janus" ]]; then
    echo "Installing from local repository directory..."
    cp -f "${SCRIPT_DIR}/bin/janus" "$TARGET_BIN"
    cp -f "${SCRIPT_DIR}/completions/janus.bash" "$TARGET_COMPLETION"
    if [[ ! -f "${TARGET_CONFIG_DIR}/janus.conf" ]]; then
        cp -f "${SCRIPT_DIR}/etc/janus.conf.example" "${TARGET_CONFIG_DIR}/janus.conf.example"
    fi
else
    echo "Downloading latest Janus CLI from GitHub..."
    curl -fsSL "${REPO_RAW_URL}/bin/janus" -o "$TARGET_BIN"
    curl -fsSL "${REPO_RAW_URL}/completions/janus.bash" -o "$TARGET_COMPLETION"
    if [[ ! -f "${TARGET_CONFIG_DIR}/janus.conf" ]]; then
        curl -fsSL "${REPO_RAW_URL}/etc/janus.conf.example" -o "${TARGET_CONFIG_DIR}/janus.conf.example"
    fi
fi

chmod 755 "$TARGET_BIN"
chmod 644 "$TARGET_COMPLETION"

echo ""
echo "✓ Janus CLI installed successfully to ${TARGET_BIN}"
echo "✓ Bash autocompletion installed to ${TARGET_COMPLETION}"
echo ""
echo "Try running:"
echo "  janus status"
echo "  janus help"

<div align="center">

# ⚡ Janus CLI

### Unified Command Center for Hybrid Gaming & Dual-Boot Home Servers

[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)
[![Platform: Linux](https://img.shields.io/badge/Platform-Ubuntu%20%7C%20Debian-E95420.svg?logo=ubuntu&logoColor=white)](https://ubuntu.com)
[![Shell](https://img.shields.io/badge/Shell-Bash-4EAA25.svg?logo=gnubash&logoColor=white)](bin/janus)
[![Release](https://img.shields.io/github/v/release/P1gBagPt-Homelab/janus-cli?include_prereleases&color=7289da)](https://github.com/P1gBagPt-Homelab/janus-cli/releases)

*Manage hardware telemetry, NVIDIA GPU compute, multi-disk pools, Docker containers, and 1-click dual-boot switching to Windows Gaming Rig from your terminal.*

</div>

---

## 💡 Why Janus CLI?

Many homelab enthusiasts run a single powerful desktop PC that serves two distinct roles:
1. **Linux Home Server (24/7)**: Docker containers, Coolify PaaS, local databases, and AI models.
2. **Windows Gaming Rig**: Booting into Windows to unleash the GPU on high-end games.

**The Problem**: Managing this hybrid setup from the terminal normally requires juggling fragmented commands across `nvidia-smi`, `docker`, `df`, `sensors`, `ufw`, `rclone`, and `grub-reboot`.

**The Solution**: **Janus CLI** wraps your entire dual-boot homelab into a single, cohesive command tool installed at `/usr/local/bin/janus`:

```
      ██╗ █████╗ ███╗   ██╗██╗   ██╗███████╗
      ██║██╔══██╗████╗  ██║██║   ██║██╔════╝
      ██║███████║██╔██╗ ██║██║   ██║███████╗
 ██   ██║██╔══██║██║╚██╗██║██║   ██║╚════██║
 ╚█████╔╝██║  ██║██║ ╚████║╚██████╔╝███████║
  ╚════╝ ╚═╝  ╚═╝╚═╝  ╚═══╝ ╚═════╝ ╚══════╝
   Janus CLI • Hybrid Gaming & Home Server Manager
```

---

## ✨ Features

* 📊 **Live Telemetry Dashboard (`janus status`)**: Real-time colored usage bars `[████████░░░░░░░░]` for CPU, RAM pools (up to 40GB+), multi-drive storage pools (SSD & HDD), and NVIDIA GPU VRAM/thermals/power draw.
* 🎮 **1-Click Dual-Boot Switch (`janus to-windows`)**: Automatically detects the Windows EFI entry in GRUB, issues `grub-reboot`, and restarts. When you finish gaming on Windows, simply restarting or powering off **automatically returns to Linux**!
* 🐳 **Dynamic Container Management (`janus logs`, `janus restart`)**: Fuzzy-match container names without memorizing random Docker hash IDs.
* 📦 **Automated Backups (`janus backup`)**: Triggers encrypted cloud snapshots (Rclone Crypt) and displays recent backup capacity.
* ⚡ **Full Bash Auto-Completion**: Typing `janus <TAB>` auto-completes commands, and `janus logs <TAB>` dynamically queries active Docker containers in real-time.

---

## 🚀 Quickstart Installation

### Option A: 1-Line Universal Installer (Recommended)
Run on your Ubuntu/Debian server:

```bash
curl -fsSL https://raw.githubusercontent.com/P1gBagPt-Homelab/janus-cli/main/install.sh | sudo bash
```

### Option B: Native Debian Package (`.deb`)
Download the latest pre-built `.deb` from [GitHub Releases](https://github.com/P1gBagPt-Homelab/janus-cli/releases):

```bash
sudo dpkg -i janus-cli_*_all.deb
```

---

## 📖 Command Reference

| Command | Description |
| :--- | :--- |
| `janus status` | Full hardware, GPU, Docker, and WireGuard telemetry dashboard. |
| `janus to-windows` | Safe 1-click reboot to Windows Gaming Rig (auto-reverts to Linux). |
| `janus backup` | Executes automated snapshot and encrypted cloud sync. |
| `janus backup --status` | Inspects recent local backup snapshots and cloud storage quota. |
| `janus logs <service>` | Tails live logs for any container matching the keyword (e.g. `docmost`). |
| `janus restart <svc>` | Restarts a Docker container or systemd service. |
| `janus update` | Runs APT security updates, kernel patches, and prunes unused Docker cache. |
| `janus version` | Displays installed Janus CLI version. |
| `janus help` | Displays the command cheatsheet. |

---

## ⚙️ Configuration

Janus CLI works immediately with zero configuration by auto-detecting your GRUB entries and hardware. 

To customize paths, copy the example config to `/etc/janus/janus.conf` (or `~/.janusrc`):

```bash
sudo cp /etc/janus/janus.conf.example /etc/janus/janus.conf
sudo nano /etc/janus/janus.conf
```

Available options:
```bash
# Explicit GRUB target (defaults to auto-detecting Windows Boot Manager)
# WINDOWS_GRUB_ENTRY="Windows Boot Manager (on /dev/nvme0n1p1)"

# Custom backup execution script
BACKUP_SCRIPT="/data/scripts/backup-janus.sh"

# Local backup directory
BACKUP_DIR="/data/backups/daily"

# Rclone encrypted remote name
RCLONE_REMOTE="janus-backup-encrypted:"

# Storage mount paths to monitor
STORAGE_PATHS="/ /data"
```

---

## 💡 Shell Productivity Tip

Add a single-letter alias to your `~/.bashrc`:

```bash
echo "alias j='janus'" >> ~/.bashrc
source ~/.bashrc
```

Now typing **`j`** instantly gives you your homelab's status dashboard.

---

## 📄 License

This project is licensed under the [MIT License](LICENSE).
Part of the [P1gBagPt-Homelab](https://github.com/P1gBagPt-Homelab) ecosystem.

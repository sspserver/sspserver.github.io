---
title: "Installation"
weight: 2
draft: false
description: "How to install the SSP server using automated deployment scripts."
slug: "installation"
tags: ["installation", "docs", "deployment"]
series: ["Documentation"]
series_order: 2
---

Automated deployment scripts for SSP Server using standalone mode with cross-platform support.

## 🚀 Quick Start

### Interactive Installation (Recommended)

Download and run locally for interactive mode:

```bash
curl -sSL https://raw.githubusercontent.com/sspserver/deploy/refs/heads/main/standalone/install.sh -o install.sh
chmod +x install.sh
./install.sh
```

Or use process substitution for interactive mode:

```bash
bash <(curl -sSL https://raw.githubusercontent.com/sspserver/deploy/refs/heads/main/standalone/install.sh)
```

### Automated Installation (No Prompts)

For automated deployment without user interaction:

```bash
curl -sSL https://raw.githubusercontent.com/sspserver/deploy/refs/heads/main/standalone/install.sh | bash -s -- -y
```

## 📋 System Requirements

- **OS**: Ubuntu/Debian Linux, macOS/Darwin (CentOS/RHEL planned)
- **CPU**: x86_64 architecture, minimum 2 cores
- **RAM**: Minimum 4GB
- **Storage**: Minimum 10GB free space
- **Network**: Internet connectivity for package downloads
- **Privileges**: Root or sudo access required

## 🔧 Installation Options

| Command | Mode | Description |
|---------|------|-------------|
| `./install.sh` | Interactive | Prompts for confirmation and domain configuration |
| `./install.sh -y` | Automated | Uses default settings, no user input required |
| `./install.sh -h` | Help | Shows usage information and examples |

## 🌐 Platform Support

### ✅ Fully Supported

- **Ubuntu/Debian**: Complete installation with systemd service management
- **macOS/Darwin**: Full support with launchd service management
- **DigitalOcean Droplets**: Optimized for `ubuntu-s-2vcpu-4gb` configuration

### 🔄 In Development

- **CentOS/RHEL**: Planned support with systemd

## 🌊 DigitalOcean Quick Deploy

For DigitalOcean droplet deployment, we have a dedicated comprehensive guide:

**[📖 DigitalOcean Deployment Guide](/docs/digitalocean/)**

Quick one-command deployment:

```bash
# SSH into your droplet and run:
cd /opt && bash <(curl -sSL https://raw.githubusercontent.com/sspserver/deploy/refs/heads/main/standalone/install.sh)
```

**Recommended Droplet**: `ubuntu-s-2vcpu-4gb` (2 vCPUs, 4GB RAM, 80GB SSD)

## 🛠️ What Gets Installed

### System Dependencies

- **Ubuntu/Debian**: curl, unzip, jq, git, build-essential, ca-certificates
- **macOS**: Dependencies via Homebrew or MacPorts

### Services

- **Docker**: Container runtime (Docker CE on Ubuntu, Docker Desktop on macOS)
- **SSP Server**: Main application as system service
- **Service Manager**: systemd (Linux) or launchd (macOS)

### Configuration

- Service files and configurations
- Environment settings (domains, ports, etc.)
- Logging setup with unified log format

## ⚙️ Configuration

During interactive installation, you'll be prompted to configure:

- **SSP API Domain** (default: `apidemo.sspserver.org`)
- **SSP UI Domain** (default: `demo.sspserver.org`)
- **SSP Server Domain** (default: `sspdemo.sspserver.org`)

In automated mode (`-y` flag), default values are used.

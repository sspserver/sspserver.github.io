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

- **SSP API Domain** (default: `api.sspserver.org`)
- **SSP UI Domain** (default: `control.sspserver.org`)
- **SSP Server Domain** (default: `ssp.sspserver.org`)
- **SSP JSSDK Domain** (default: `jssdk.sspserver.org`)
- **SSP Tracker Domain** (default: `ssp.sspserver.org`)

In automated mode (`-y` flag), default values are used.

## 📋 Installation Log Example

Here's a sample installation log showing the complete process:

```bash
root@adserver-test-1:/# bash <(curl -sSL https://raw.githubusercontent.com/sspserver/deploy/refs/heads/main/standalone/install.sh)
03-12-2025 12:53:10 [INFO] System Information:
OS Name: linux (6.8.0-71-generic)
OS Type: adserver-test-1
OS Arch: x86_64
03-12-2025 12:53:10 [INFO] Checking OS...
03-12-2025 12:53:10 [OK] Check OS [ubuntu]
03-12-2025 12:53:10 [INFO] Checking architecture...
03-12-2025 12:53:10 [OK] Check architecture [x86_64]
03-12-2025 12:53:10 [INFO] Checking CPU...
03-12-2025 12:53:10 [OK] Check CPU [2]
03-12-2025 12:53:11 [INFO] Checking RAM...
03-12-2025 12:53:11 [OK] Check RAM [3.82 GB]
03-12-2025 12:53:11 [INFO] Checking storage...
03-12-2025 12:53:11 [OK] Free storage check [73.72 GB] in /var/lib
03-12-2025 12:53:11 [OK] All checks passed. Proceeding with the installation...
===============================================

Do you want to continue with the installation? [y/N]: y
03-12-2025 12:53:12 [INFO] Starting installation...
03-12-2025 12:53:12 [INFO] Installing dependencies...
03-12-2025 12:53:16 [OK] Package 'curl' is already installed.
03-12-2025 12:53:16 [OK] Package 'unzip' is already installed.
03-12-2025 12:53:16 [OK] Package 'jq' is already installed.
03-12-2025 12:53:16 [OK] Package 'git' is already installed.
03-12-2025 12:53:16 [OK] Package 'build-essential' is already installed.
03-12-2025 12:53:16 [INFO] Checking for Docker...
03-12-2025 12:53:16 [OK] Docker is already installed
03-12-2025 12:53:18 [INFO] Setting domains of the service...
Enter the domain for the project [sspserver.org]: mydomain.com
Enter the domain for the SSP API server [api.mydomain.com]:
Enter the domain for the SSP UI server [control.mydomain.com]:
Enter the domain for the SSP AD server [ssp.mydomain.com]:
Enter the domain for the SSP JSSDK server [jssdk.mydomain.com]:
Enter the domain for the SSP Tracker server [ssp.mydomain.com]:
03-12-2025 12:54:26 [OK] SSP service started successfully
```

The installation process includes:

1. System requirements validation
2. Dependency installation and verification
3. Docker setup confirmation
4. Domain configuration for all services
5. Database setup (PostgreSQL and ClickHouse)
6. Service deployment and startup

---
title: "DigitalOcean Deployment"
weight: 4
draft: false
description: "Complete guide for deploying SSP Server on DigitalOcean droplets with optimal configuration."
slug: "digitalocean"
tags: ["digitalocean", "droplet", "cloud", "deployment"]
series: ["Documentation"]
series_order: 4
---

## 🌊 DigitalOcean Droplet Deployment

Deploy SSP Server on DigitalOcean with our optimized one-click installation process. This guide covers everything from droplet creation to production-ready configuration.

### 📋 Minimal Requirements

For a production-ready SSP Server deployment on DigitalOcean, use the following droplet specification:

- **Droplet Size**: `ubuntu-s-2vcpu-4gb` (2 vCPUs, 4GB RAM)
- **Operating System**: Ubuntu 20.04 LTS or later
- **Storage**: 80GB+ SSD (minimum 64GB recommended)
- **Network**: Standard networking with IPv4
- **Region**: Choose closest to your target audience

### 🚀 Step-by-Step Installation

#### 1. Create and Access Your Droplet

```bash
# SSH into your droplet as root
ssh root@your-droplet-ip
```

#### 2. Prepare Installation Directory

```bash
# Navigate to the optimal installation directory
cd /opt/

# Create SSP Server directory (if not exists)
mkdir -p sspserver
cd sspserver
```

#### 3. Run One-Click Installation

**Interactive Installation (Recommended for first-time setup):**

```bash
bash <(curl -sSL https://raw.githubusercontent.com/sspserver/deploy/refs/heads/main/standalone/install.sh)
```

**Automated Installation with default settings:**

```bash
curl -sSL https://raw.githubusercontent.com/sspserver/deploy/refs/heads/main/standalone/install.sh | bash -s -- -y
```

### 📊 Installation Process Overview

The installer will automatically:

1. **System Check**: Verify OS (Ubuntu), architecture (x86_64), CPU (2+ cores), RAM (4GB+), and storage (64GB+)
2. **Dependency Installation**: Install curl, unzip, jq, git, build-essential, ca-certificates
3. **Docker Setup**: Install Docker CE and configure container runtime
4. **Service Configuration**: Download and configure SSP Server services
5. **Environment Setup**: Configure domains and environment variables
6. **Service Start**: Start all SSP Server components via systemd

### 📝 Expected Installation Output

```text
16-11-2025 10:22:04 [INFO] System Information:
OS Name: linux (6.11.0-9-generic)
OS Type: ubuntu-s-2vcpu-4gb-fra1-01-demossp
OS Arch: x86_64
16-11-2025 10:22:04 [OK] Check OS [ubuntu]
16-11-2025 10:22:04 [OK] Check architecture [x86_64]
16-11-2025 10:22:04 [OK] Check CPU [2]
16-11-2025 10:22:04 [OK] Check RAM [3.82 GB]
16-11-2025 10:22:04 [OK] Free storage check [64.94 GB] in /var/lib
16-11-2025 10:22:04 [OK] All checks passed. Proceeding with the installation...

===============================================

16-11-2025 10:22:04 [INFO] Ready to download and execute OS-specific installation script.
16-11-2025 10:22:04 [INFO] This will install SSP Server and all required dependencies.

Do you want to continue with the installation? [y/N]: y
16-11-2025 10:22:10 [INFO] Starting installation...
16-11-2025 10:22:21 [OK] SSP service started successfully
```

### ⚙️ Post-Installation Configuration

After successful installation, your SSP Server will be running with these default domains:

- **API Domain**: `api.sspserver.org`
- **Control Panel**: `control.sspserver.org`
- **SSP Endpoint**: `ssp.sspserver.org`

### 🛡️ DigitalOcean Specific Configuration

#### Firewall Setup

Configure DigitalOcean firewall to allow necessary traffic:

```bash
# Using DigitalOcean Cloud Firewall (recommended)
# Allow HTTP (80) and HTTPS (443) inbound traffic
# Allow SSH (22) for administration

# Or using UFW on the droplet
ufw allow 22/tcp    # SSH
ufw allow 80/tcp    # HTTP
ufw allow 443/tcp   # HTTPS
ufw enable
```

#### Domain Configuration

1. **Point your domains** to the droplet's public IP address via DNS A records
2. **Update environment variables** in `/opt/sspserver/.env` with your custom domains
3. **Restart services** after domain changes:

```bash
systemctl restart sspserver
```

> **💡 Pro Tip**: For enhanced performance, security, and SSL management, consider using Cloudflare as your DNS provider. See our **[Cloudflare Configuration Guide](/docs/cloudflare/)** for complete setup instructions including DNS records, SSL certificates, and performance optimizations.

#### SSL Certificates

For production deployments, set up SSL certificates:

```bash
# Install Certbot for Let's Encrypt
apt update && apt install -y certbot

# Generate certificates for your domains
certbot certonly --standalone -d your-api-domain.com
certbot certonly --standalone -d your-control-domain.com
certbot certonly --standalone -d your-ssp-domain.com
```

### 📈 Monitoring and Maintenance

#### Resource Monitoring

Enable DigitalOcean monitoring for your droplet:

- CPU usage tracking
- Memory utilization
- Disk I/O monitoring
- Network traffic analysis

#### Automated Backups

Set up automated backups:

1. **DigitalOcean Snapshots**: Enable weekly automated snapshots
2. **Database Backups**: Configure PostgreSQL backups
3. **Configuration Backups**: Backup `/opt/sspserver/` directory

```bash
# Manual backup command
tar -czf sspserver-backup-$(date +%Y%m%d).tar.gz /opt/sspserver/
```

### ✅ Verification and Testing

#### Service Status Check

```bash
# Check if SSP Server is running
systemctl status sspserver

# View installation logs
tail -f /var/log/sspserver/sspserver_1click_standalone.log

# Check Docker containers
docker ps

# Check all services are healthy
docker-compose -f /opt/sspserver/docker-compose.yml ps
```

#### Health Endpoints

Test your SSP Server endpoints:

```bash
# Test API endpoint
curl -I http://your-droplet-ip:8080/health

# Test Control Panel
curl -I http://your-droplet-ip:3000

# Test SSP endpoint
curl -I http://your-droplet-ip:8090/health
```

### 🔧 Troubleshooting

#### Common DigitalOcean Issues

1. **Port Access Issues**: Check DigitalOcean firewall settings
2. **Domain Resolution**: Verify DNS A records point to droplet IP
3. **Resource Constraints**: Monitor CPU/RAM usage in DigitalOcean dashboard
4. **Docker Issues**: Restart Docker service if containers fail

#### Debug Commands

```bash
# Check droplet resources
free -h                    # Memory usage
df -h                     # Disk usage
top                       # CPU usage

# Check network connectivity
netstat -tuln             # Open ports
curl -I http://localhost:8080  # Local connectivity test

# Check SSP Server logs
journalctl -u sspserver -f    # Service logs
docker logs sspserver_api_1   # Container logs
```

### 🔄 Updates and Scaling

#### Updating SSP Server

```bash
# Re-run installation script to update
cd /opt/sspserver
bash <(curl -sSL https://raw.githubusercontent.com/sspserver/deploy/refs/heads/main/standalone/install.sh)
```

#### Scaling Options

- **Vertical Scaling**: Resize droplet to larger configuration
- **Load Balancer**: Use DigitalOcean Load Balancer for multiple droplets
- **Database**: Consider DigitalOcean Managed PostgreSQL for production

### 💰 Cost Optimization

- **Right-sizing**: Monitor resource usage and adjust droplet size
- **Reserved Instances**: Use DigitalOcean reserved pricing for long-term deployments
- **Snapshots**: Regular snapshots for disaster recovery
- **Monitoring**: Set up alerts for unusual resource usage

### 📞 Support and Resources

- **DigitalOcean Documentation**: [DigitalOcean Docs](https://docs.digitalocean.com/)
- **SSP Server Issues**: [GitHub Issues](https://github.com/sspserver/deploy/issues)
- **Community**: [SSP Server Community](https://community.sspserver.org)
- **Professional Support**: Contact for enterprise deployment assistance

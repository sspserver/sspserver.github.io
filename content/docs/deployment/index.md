---
title: "Deployment"
weight: 3
draft: false
description: "Complete deployment guide for SSP Server with service management and troubleshooting."
slug: "deployment"
tags: ["deployment", "service-management", "troubleshooting"]
series: ["Documentation"]
series_order: 3
---

## 📝 Logging

All installation activities are logged with unified format:

- **Log Location**: `/var/log/sspserver/sspserver_1click_standalone.log`
- **Log Format**: `[TIMESTAMP] [TYPE] Message`
- **Log Types**: `[ERROR]`, `[INFO]`, `[OK]`

## 🔍 Service Management

### Ubuntu/Debian (systemd)

```bash
# Check service status
systemctl status sspserver

# Start/stop/restart service
sudo systemctl start sspserver
sudo systemctl stop sspserver
sudo systemctl restart sspserver

# View logs
journalctl -u sspserver -f
```

### macOS (launchd)

```bash
# Check service status
sudo launchctl list | grep sspserver

# Start/stop service
sudo launchctl load /Library/LaunchDaemons/com.sspserver.plist
sudo launchctl unload /Library/LaunchDaemons/com.sspserver.plist

# View logs
tail -f /var/log/sspserver/sspserver_1click_standalone.log
```

## 🆘 Troubleshooting

### Common Issues

1. **Permission Denied**: Ensure you have sudo/root privileges
2. **Network Issues**: Check internet connectivity and firewall settings
3. **Port Conflicts**: Ensure required ports are available
4. **Disk Space**: Verify sufficient free space (minimum 10GB)

### Debug Information

```bash
# Check system requirements
./install.sh --help

# View installation logs
tail -f /var/log/sspserver/sspserver_1click_standalone.log

# Check service status
# Ubuntu/Debian: systemctl status sspserver
# macOS: sudo launchctl list | grep sspserver
```

## 🔄 Updates

To update SSP Server, simply re-run the installation script:

### Interactive update

```bash
bash <(curl -sSL https://raw.githubusercontent.com/sspserver/deploy/refs/heads/main/standalone/install.sh)
```

### Automated update

```bash
curl -sSL https://raw.githubusercontent.com/sspserver/deploy/refs/heads/main/standalone/install.sh | bash -s -- -y
```

## 📁 Project Structure

```text
standalone/
├── install.sh          # Universal installer with system checks
├── systems/
│   ├── ubuntu.sh       # Ubuntu/Debian specific installer
│   └── darwin.sh       # macOS/Darwin specific installer
└── README.md          # Documentation
```

## 📞 Support

- **Documentation**: [SSP Server Docs](https://docs.sspserver.org)
- **Issues**: [GitHub Issues](https://github.com/sspserver/deploy/issues)
- **Community**: [SSP Server Community](https://community.sspserver.org)

## ⚖️ License

This project is licensed under the terms specified in the [LICENSE](LICENSE) file.

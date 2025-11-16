---
title: "Quick start"
weight: 1
draft: false
description: "Get started with SSP Server in minutes using our one-click installation"
# slug: "quickstart"
tags: ["quickstart", "docs", "installation"]
series: ["Documentation"]
series_order: 1
---

{{< lead >}}
SSP Server is a powerful Supply-Side Platform that helps publishers monetize their inventory through Real-Time Bidding (RTB). Get started in minutes with our automated deployment script.
{{< /lead >}}

## One-Click Installation

The fastest way to get SSP Server running is with our automated installation script:

```bash
curl -sSL https://raw.githubusercontent.com/sspserver/deploy/refs/heads/main/standalone/install.sh | bash -s -- -y
```

This command will:

- Detect your operating system
- Install all required dependencies
- Set up Docker containers
- Configure the SSP Server services
- Start the application

## Try the Demo

Once installed, or to see SSP Server in action before installing, visit our demo:

**[🚀 Try SSP Server Demo](https://demo.sspserver.org/)**

The demo provides access to the admin panel where you can:

- Manage RTB (Real-Time Bidding) connections
- Configure websites and ad placements
- Monitor advertising performance
- Optimize your advertising strategy in real-time

## Next Steps

After installation:

1. **Configure your domains** - Set up your custom domains for the API, UI, and SSP endpoints
2. **Add your first website** - Configure ad placements and inventory
3. **Connect RTB sources** - Integrate with demand-side platforms
4. **Monitor performance** - Track revenue and optimization metrics

For detailed configuration and advanced features, see our [Installation Guide](/docs/installation/) and [Deployment Documentation](/docs/deployment/).

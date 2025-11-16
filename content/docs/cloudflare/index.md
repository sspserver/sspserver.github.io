---
title: "Cloudflare Configuration"
weight: 5
draft: false
description: "Complete guide for configuring Cloudflare DNS, SSL, and security settings for SSP Server."
slug: "cloudflare"
tags: ["cloudflare", "dns", "ssl", "security", "cdn"]
series: ["Documentation"]
series_order: 5
---

## ☁️ Cloudflare Configuration for SSP Server

Configure Cloudflare as your DNS provider and CDN for enhanced performance, security, and SSL management. This guide covers DNS setup, SSL configuration, and security optimizations for your SSP Server deployment.

## 🌐 DNS Configuration

### Required DNS Records

Set up the following DNS records in your Cloudflare dashboard for optimal SSP Server configuration:

| Type | Name | Content | Proxy Status | TTL | Purpose |
|------|------|---------|--------------|-----|---------|
| `A` | `api` | `xxx.xxx.xxx.xxx` | ✅ Proxied | Auto | API endpoint |
| `A` | `control` | `xxx.xxx.xxx.xxx` | ✅ Proxied | Auto | Control panel |
| `A` | `ssp` | `xxx.xxx.xxx.xxx` | ✅ Proxied | Auto | SSP endpoint |

### Production DNS Setup

For your production SSP Server deployment, configure these records:

```text
# Replace YOUR_SERVER_IP with your actual server IP address

A     api        YOUR_SERVER_IP    Proxied    Auto    # API endpoint
A     control    YOUR_SERVER_IP    Proxied    Auto    # Control panel
A     ssp        YOUR_SERVER_IP    Proxied    Auto    # SSP ad server
A     tracker    YOUR_SERVER_IP    Proxied    Auto    # Analytics tracker
CNAME www        yourdomain.com    Proxied    Auto    # WWW redirect
```

### DNS Management Commands

Using Cloudflare CLI (optional):

```bash
# Install Cloudflare CLI
npm install -g @cloudflare/cli

# Login to Cloudflare
cf login

# Add DNS records
cf dns create --type A --name api --content YOUR_SERVER_IP --proxied
cf dns create --type A --name control --content YOUR_SERVER_IP --proxied
cf dns create --type A --name ssp --content YOUR_SERVER_IP --proxied
cf dns create --type A --name tracker --content YOUR_SERVER_IP --proxied
```

## 🔒 SSL/TLS Configuration

### SSL/TLS Settings

Configure SSL for secure connections:

1. **SSL/TLS Mode**: Set to **Full (strict)** for end-to-end encryption
2. **Edge Certificates**: Enable **Always Use HTTPS**
3. **Minimum TLS Version**: Set to **TLS 1.2** or higher
4. **TLS 1.3**: Enable for improved performance and security

### SSL Certificate Types

#### Universal SSL (Free)

Cloudflare automatically provisions SSL certificates for:

- `yourdomain.com`
- `*.yourdomain.com` (wildcard)
- `www.yourdomain.com`

#### Advanced Certificate Manager (Paid)

For custom hostnames and extended validation:

- Custom certificate authorities
- Extended validation (EV) certificates
- Custom certificate validity periods

### Origin Certificate Setup

Generate origin certificates for your server:

1. **Go to SSL/TLS > Origin Server**
2. **Create Certificate** with these hostnames:
   - `api.yourdomain.com`
   - `control.yourdomain.com`
   - `ssp.yourdomain.com`
   - `tracker.yourdomain.com`

3. **Install on your server**:

```bash
# Save certificate and private key
sudo mkdir -p /etc/ssl/cloudflare
sudo nano /etc/ssl/cloudflare/cert.pem    # Paste certificate
sudo nano /etc/ssl/cloudflare/key.pem     # Paste private key

# Set proper permissions
sudo chmod 600 /etc/ssl/cloudflare/key.pem
sudo chmod 644 /etc/ssl/cloudflare/cert.pem
```

## 🛡️ Security Configuration

### Firewall Rules

Set up Cloudflare firewall rules for SSP Server protection:

#### Rule 1: Block Known Bad Bots

```text
Field: User Agent
Operator: contains
Value: bot|crawler|spider
Action: Block
```

#### Rule 2: Rate Limiting for API

```text
Field: URI Path
Operator: contains
Value: /api/
Rate: 100 requests per minute
Action: Challenge
```

#### Rule 3: Geographic Restrictions (Optional)

```text
Field: Country
Operator: not in
Value: US, CA, EU countries
Action: Block
```

### Security Headers

Enable security headers in **Security > Settings**:

- ✅ **Security Headers**: Enable
- ✅ **HSTS**: Enable with subdomains
- ✅ **HSTS Preload**: Enable
- ✅ **No-Sniff Header**: Enable
- ✅ **X-Frame-Options**: DENY

### Bot Management

Configure bot protection:

1. **Super Bot Fight Mode**: Enable (free)
2. **Bot Score Threshold**: Set to 30 or lower
3. **Static Resource Protection**: Enable
4. **Verified Bot Categories**: Allow search engines, monitoring

## ⚡ Performance Optimization

### Caching Rules

Configure caching for SSP Server components:

#### Static Assets Caching

```text
Rule Name: Static Assets
If: URI Path matches regex .*\.(css|js|png|jpg|jpeg|gif|ico|svg|woff|woff2|ttf)$
Then: Cache Level = Everything, Edge TTL = 1 month
```

#### API Response Caching

```text
Rule Name: API Responses
If: URI Path starts with /api/
Then: Cache Level = Bypass, Browser TTL = 0
```

#### HTML Page Caching

```text
Rule Name: HTML Pages
If: URI Path ends with / OR URI Path ends with .html
Then: Cache Level = Standard, Edge TTL = 4 hours
```

### Page Rules

Set up page rules for optimal performance:

1. **API Endpoints** (`api.yourdomain.com/*`):
   - Cache Level: Bypass
   - Security Level: High
   - SSL: Full (strict)

2. **Control Panel** (`control.yourdomain.com/*`):
   - Cache Level: Standard
   - Security Level: Medium
   - Browser Integrity Check: On

3. **SSP Endpoint** (`ssp.yourdomain.com/*`):
   - Cache Level: Bypass
   - Security Level: Medium
   - Performance optimizations: On

### Speed Optimizations

Enable performance features:

- ✅ **Auto Minify**: HTML, CSS, JavaScript
- ✅ **Brotli Compression**: Enable
- ✅ **Early Hints**: Enable
- ✅ **Rocket Loader**: Enable (test carefully with your ads)
- ✅ **Mirage**: Enable for image optimization
- ✅ **Polish**: Lossless image compression

## 📊 Analytics and Monitoring

### Analytics Configuration

Enable Cloudflare Analytics:

1. **Web Analytics**: Enable for traffic insights
2. **Security Analytics**: Monitor threats and attacks
3. **Performance Analytics**: Track Core Web Vitals
4. **Bot Analytics**: Monitor bot traffic patterns

### Log Management

Configure log retention and analysis:

```bash
# Using Logpush (Enterprise feature)
# Push logs to external storage for analysis
curl -X POST "https://api.cloudflare.com/client/v4/zones/{zone_id}/logpush/jobs" \
  -H "Authorization: Bearer {api_token}" \
  -H "Content-Type: application/json" \
  --data '{
    "enabled": true,
    "name": "sspserver-logs",
    "destination_conf": "s3://mybucket/logs?region=us-east-1"
  }'
```

### Health Checks

Set up health monitoring:

1. **Create Health Check**:
   - **URL**: `https://api.yourdomain.com/health`
   - **Method**: GET
   - **Interval**: 60 seconds
   - **Timeout**: 10 seconds

2. **Notification Settings**:
   - Email alerts for downtime
   - Webhook notifications to Slack/Discord
   - SMS alerts for critical issues

## 🔧 Advanced Configuration

### Load Balancing

For multiple server setup:

```bash
# Create origin pool
curl -X POST "https://api.cloudflare.com/client/v4/user/load_balancers/pools" \
  -H "Authorization: Bearer {api_token}" \
  -H "Content-Type: application/json" \
  --data '{
    "name": "sspserver-pool",
    "origins": [
      {
        "name": "server-1",
        "address": "161.35.29.27",
        "enabled": true,
        "weight": 1
      },
      {
        "name": "server-2", 
        "address": "161.35.29.28",
        "enabled": true,
        "weight": 1
      }
    ]
  }'
```

### Workers Configuration

Deploy Cloudflare Workers for custom logic:

```javascript
// Example: Request routing and modification
addEventListener('fetch', event => {
  event.respondWith(handleRequest(event.request))
})

async function handleRequest(request) {
  const url = new URL(request.url)
  
  // Route API requests to specific backend
  if (url.pathname.startsWith('/api/')) {
    return fetch(request)
  }
  
  // Add custom headers for SSP requests
  if (url.pathname.startsWith('/ssp/')) {
    const response = await fetch(request)
    const newResponse = new Response(response.body, response)
    newResponse.headers.set('X-SSP-Server', 'cloudflare-worker')
    return newResponse
  }
  
  return fetch(request)
}
```

### Argo Smart Routing

Enable Argo for intelligent routing:

1. **Enable Argo Smart Routing**: Improves performance by up to 30%
2. **Argo Tiered Caching**: Reduces origin server load
3. **Monitor Performance**: Check analytics for improvements

## 🔍 Troubleshooting

### Common Issues

#### DNS Propagation

```bash
# Check DNS propagation
dig @8.8.8.8 api.yourdomain.com
dig @1.1.1.1 api.yourdomain.com

# Check from multiple locations
nslookup api.yourdomain.com 8.8.8.8
nslookup api.yourdomain.com 1.1.1.1
```

#### SSL Certificate Issues

```bash
# Test SSL certificate
openssl s_client -connect api.yourdomain.com:443 -servername api.yourdomain.com

# Check certificate chain
curl -vI https://api.yourdomain.com
```

#### Origin Server Connectivity

```bash
# Test origin server directly
curl -H "Host: api.yourdomain.com" http://YOUR_SERVER_IP/health

# Check Cloudflare connectivity
curl -H "CF-Connecting-IP: 1.2.3.4" https://api.yourdomain.com/health
```

### Debug Tools

Use Cloudflare debugging tools:

1. **Trace Route**: Check request path
2. **Security Events**: Monitor blocked requests  
3. **Analytics**: Review traffic patterns
4. **Edge Logs**: Examine request/response details

### Support Resources

- **Cloudflare Community**: [community.cloudflare.com](https://community.cloudflare.com)
- **Cloudflare Docs**: [developers.cloudflare.com](https://developers.cloudflare.com)
- **Status Page**: [cloudflarestatus.com](https://cloudflarestatus.com)
- **Support Tickets**: Available with paid plans

## 📋 Configuration Checklist

### Initial Setup

- [ ] Domain added to Cloudflare
- [ ] Nameservers updated at registrar
- [ ] DNS records configured
- [ ] SSL/TLS mode set to Full (strict)
- [ ] Always Use HTTPS enabled

### Security Configuration

- [ ] Firewall rules configured
- [ ] Security headers enabled
- [ ] Bot management configured
- [ ] Origin certificates installed
- [ ] Rate limiting rules set

### Performance Optimization

- [ ] Caching rules configured
- [ ] Page rules optimized
- [ ] Auto minify enabled
- [ ] Compression enabled
- [ ] Image optimization enabled

### Monitoring Setup

- [ ] Analytics enabled
- [ ] Health checks configured
- [ ] Alert notifications set
- [ ] Log management configured
- [ ] Performance monitoring active

## 💡 Best Practices

1. **Start with Conservative Settings**: Begin with basic configuration and gradually optimize
2. **Test Changes Gradually**: Use staged rollouts for major configuration changes
3. **Monitor Performance**: Regular check Core Web Vitals and user experience metrics
4. **Security First**: Prioritize security settings before performance optimizations
5. **Regular Updates**: Keep configurations updated as Cloudflare adds new features
6. **Documentation**: Document all custom rules and configurations for team reference

## 📞 Support

- **SSP Server Issues**: [GitHub Issues](https://github.com/sspserver/deploy/issues)
- **Cloudflare Configuration**: [Cloudflare Support](https://support.cloudflare.com)
- **Community Help**: [SSP Server Community](https://community.sspserver.org)
- **Professional Services**: Contact for enterprise Cloudflare setup assistance

---
name: proxy-ws-stunnel-setup
description: "Set up websocket SSH proxy with TLS stunnel forwarding."
version: 1.0.0
author: ajun-x-linux
license: MIT
platforms: [linux]
metadata:
  tags: [websocket, ssh, proxy, stunnel, tls]
  homepage: https://github.com/ica4me/Ws-Epro
---

# Proxy WebSocket SSH and TLS Stunnel Setup

This skill covers end-to-end setup of websocket SSH proxy using Ws-Epro Go backend and stunnel4 TLS.

## Procedure

1. Remove nginx, update packages, install openssh-server, stunnel4, haproxy, netcat, wget, curl.
2. Download Ws-Epro binary to /usr/bin/ws and mark executable.
3. Configure /etc/ws/config.conf for ports 8080 and 10015 forwarding to local sshd port 22 (ws backend on internal ports).
4. Create systemd service /etc/systemd/system/ws.service for ws backend.
5. Generate TLS cert at /etc/stunnel/stunnel.pem using openssl.
6. Create /etc/stunnel/stunnel.conf for TLS forwarding from 10015 (internal) — stunnel listens on internal port only.
7. Configure haproxy as gatekeeper on public ports:
   - Frontend tcp *:80 -> backend ws_server 127.0.0.1:8080
   - Frontend tcp *:443 ssl crt /etc/stunnel/stunnel.pem -> backend tls_server 127.0.0.1:10015
8. Enable and start ws, haproxy services. Stop/disable stunnel4 if haproxy handles 443.
9. Open firewall ports 22, 80, 443.
10. Manage users with expiration and session limits via Linux users and /etc/ws/user_limit.conf.
11. Provide command-driven CLI tool menu-ssh for user management (non-interactive args only).

## Pitfalls

- Ensure binary exists and executable before service startup.
- Check and free port 443 if blocked for stunnel/haproxy.
- Use non-interactive CLI args for user management.
- Create /etc/ws before config files.
- Remove conflicting nginx.
- Validate inputs in CLI tools.
- Stunnel4 uses init.d script; enable via /etc/default/stunnel4.
- Haproxy frontend and backend modes must match (both tcp for websocket/SSL proxying).
- If haproxy handles 443, stop stunnel4 to avoid address-already-in-use conflict.
- Ws-Epro ws backend should listen on internal ports (8080, 10015), not public ports.
- Haproxy stats socket path /run/haproxy/admin.sock requires proper permissions.
- SSL cert for haproxy must be combined cert+key in single PEM file.

## Testing

Verify listening ports with `ss -tlnp`, service status, and websocket handshake tests.


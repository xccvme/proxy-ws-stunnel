# Proxy WS Stunnel Setup

This repository contains an improved automated setup script for the Ws-Epro WebSocket SSH proxy along with HAProxy and Stunnel integration.

## Supported OS
- Debian 11, 12, 13
- Ubuntu 20.04, 22.04, 24.04

## Features
- Installs required dependencies including Python3, pip, websockets module for testing.
- Sets up Ws-Epro WebSocket proxy on internal ports 8080 and 10015.
- Configures Stunnel on port 4443 with a self-signed certificate.
- Installs and configures HAProxy to proxy ports 80 -> 8080 and 443 -> 4443 with SSL termination.
- Enables and starts all relevant services automatically.
- Provides `menu-ssh` command for managing user accounts with expiration and IP session limits.

## Installation

Run the following commands on your server:

```bash
wget https://raw.githubusercontent.com/xccvme/proxy-ws-stunnel/main/setup-improved.sh -O setup-improved.sh
chmod +x setup-improved.sh
sudo ./setup-improved.sh
```

## Usage

- Use `menu-ssh` command to manage SSH proxy user accounts:

```bash
# Create user
menu-ssh create <username> <password> <expiration_days> <ip_session_limit>

# List users
menu-ssh list

# Delete user
menu-ssh delete <username>

# Uninstall proxy
menu-ssh uninstall
```

- Test the WebSocket SSH proxy on ports 80 (WS) and 443 (WSS).

## Notes

- The setup script disables Nginx if installed to avoid port conflicts.
- Stunnel is configured to use port 4443 to avoid conflicts; HAProxy handles SSL on 443.

---

Made by xccvme

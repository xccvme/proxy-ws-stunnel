#!/bin/bash

# Improved setup script for Ws-Epro + HAProxy + Stunnel

set -e

apt-get update
apt-get install -y openssh-server stunnel4 ufw curl wget openssl netcat-traditional python3 python3-pip python3-venv python3-dev gcc haproxy
pip3 install websockets

if systemctl is-active --quiet nginx; then
  systemctl stop nginx
  systemctl disable nginx
  apt-get remove -y nginx
fi

mkdir -p /etc/ws
wget -O /usr/bin/ws https://raw.githubusercontent.com/ica4me/Ws-Epro/main/ws
chmod +x /usr/bin/ws

cat <<EOF > /etc/ws/config.conf
verbose: 0
listen:
- target_host: 127.0.0.1
  target_port: 22
  listen_port: 8080
  bufLen: 16384
- target_host: 127.0.0.1
  target_port: 22
  listen_port: 10015
  bufLen: 16384
EOF

cat <<EOF > /etc/systemd/system/ws.service
[Unit]
Description=WebSocket TCP relay (clean)
After=syslog.target network-online.target

[Service]
User=root
NoNewPrivileges=true
ExecStart=/usr/bin/ws -f /etc/ws/config.conf
Restart=on-failure
LimitNOFILE=65535

[Install]
WantedBy=multi-user.target
EOF

systemctl daemon-reload
systemctl enable --now ws.service

openssl req -new -newkey rsa:2048 -days 3650 -nodes -x509 -subj "/CN=myvpn" -keyout /tmp/k.pem -out /tmp/c.pem
cat /tmp/c.pem /tmp/k.pem > /etc/stunnel/stunnel.pem
chmod 600 /etc/stunnel/stunnel.pem
rm -f /tmp/k.pem /tmp/c.pem

cat <<EOF > /etc/stunnel/stunnel.conf
pid = /var/run/stunnel.pid
[ws-tls]
accept = 4443
connect = 127.0.0.1:10015
cert = /etc/stunnel/stunnel.pem
EOF

sed -i 's/^ENABLED=0/ENABLED=1/' /etc/default/stunnel4
systemctl enable --now stunnel4

cat <<EOF > /etc/haproxy/haproxy.cfg
###############################
# Global section
###############################
global
    log /dev/log local0
    log /dev/log local1 notice
    chroot /var/lib/haproxy
    stats socket /run/haproxy/admin.sock mode 660 level admin expose-fd listeners
    stats timeout 30s
    user haproxy
    group haproxy
    daemon

###############################
# Default settings
###############################
defaults
    log     global
    option  dontlognull
    timeout connect 5000
    timeout client  50000
    timeout server  50000

###############################
# Frontend and backend
###############################
frontend http_front
    bind *:80
    mode tcp
    default_backend ws_backend

frontend https_front
    bind *:443 ssl crt /etc/stunnel/stunnel.pem
    mode tcp
    default_backend tls_backend

backend ws_backend
    mode tcp
    server ws_server 127.0.0.1:8080 check

backend tls_backend
    mode tcp
    server tls_server 127.0.0.1:4443 check
EOF

systemctl restart haproxy
systemctl enable haproxy

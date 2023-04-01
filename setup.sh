#!/bin/bash
PORTS=(80 443)
CLOUDFLARE_URL="https://www.cloudflare.com/ips-v4"


# Retrieve list of Cloudflare IPv4 addresses
CLOUDFLARE_IPS=$(wget -qO- "$CLOUDFLARE_URL")


# Whitelist
for ip in $CLOUDFLARE_IPS; do
    for port in "${PORTS[@]}"; do
        iptables -A INPUT -p tcp -s $ip --dport $port -j ACCEPT
    done
done


# Deny all other ip adressess
for port in "${PORTS[@]}"; do
    iptables -A INPUT -p tcp --dport $port -j DROP
done


# Keep the container running
tail -f /dev/null
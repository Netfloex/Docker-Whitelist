#!/bin/bash

CLOUDFLARE_URL="https://www.cloudflare.com/ips-v4"


# Retrieve list of Cloudflare IPv4 addresses
CLOUDFLARE_IPS=$(wget -qO- "$CLOUDFLARE_URL")


# Whitelist
for ip in $CLOUDFLARE_IPS; do
    iptables -A INPUT -p tcp -s $ip --dport 80 -j ACCEPT
    iptables -A INPUT -p tcp -s $ip --dport 443 -j ACCEPT
done


# Deny all other ip adressess 
iptables -A INPUT -p tcp --dport 80 -j DROP
iptables -A INPUT -p tcp --dport 443 -j DROP


# Keep the container running
tail -f /dev/null
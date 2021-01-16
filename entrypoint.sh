#!/usr/bin/env sh

#
# iptables configuration
#
# The following allows in- and outbound traffic
# within a certain `CIDR` (default: `192.168.0.0/24`),
# but blocks all other network traffic.
#

# Best to get docker bridge subnet dynamically by setting env variable with $(docker network inspect bridge | jq -r '.[0].IPAM.Config[0].Subnet')

ACCEPT_CIDR=${ALLOWED_CIDR:-192.168.0.0/24}

iptables -A INPUT -s $ACCEPT_CIDR -j ACCEPT
iptables -A INPUT -j DROP
iptables -A OUTPUT -d $ACCEPT_CIDR -j ACCEPT
iptables -A OUTPUT -j DROP

# export LOCAL_API="http://$(ip address | grep -E 'inet.*brd' | awk '{ print $2 }')/v1/maps/"

exec sudo -u app "$@"

# Enable IPv6
sysctl -w net.ipv6.conf.all.disable_ipv6=0
sysctl -w net.ipv6.conf.all.forwarding=1

ip6tables -A FORWARD -i veth0 -j DROP

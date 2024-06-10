# Enable IPv6
sysctl -w net.ipv6.conf.all.disable_ipv6=0
sysctl -w net.ipv6.conf.all.forwarding=1

# Create a network namespace
ip netns add NS

ip netns exec NS sysctl -w net.ipv6.conf.all.disable_ipv6=0

ip netns exec NS sysctl -w net.ipv6.conf.all.forwarding=1


# Create a bridge
ip netns exec NS ip link add name br0 type bridge

# Create a veth pair
ip link add NS-veth1 type veth peer name veth0
# Assign the veth interfaces to the network namespaces
ip link set NS-veth1 netns NS
# Assign veth1 to br0
ip netns exec NS ip link set NS-veth1 master br0

# Assign IP addresses to the veth0 interfaces
ip -6 addr add 2001:200:0:1cdc:1e60::2110:2/112 dev veth0

# Eth0 to NS
ip link set eth0 netns NS
# Assign eth0 to br0
ip netns exec NS ip link set eth0 master br0

ip6tables -A FORWARD -i veth0 -j DROP
ip netns exec NS ip6tables -t mangle -A FORWARD -p tcp --tcp-flags SYN,RST SYN -j TCPMSS --set-mss 1340

# Bring up the veth interfaces
ip netns exec NS ip link set eth0 up
ip netns exec NS ip link set br0 up
ip netns exec NS ip link set NS-veth1 up
ip link set veth0 up

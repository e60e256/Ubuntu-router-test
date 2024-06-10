# Create a network namespace
ip netns add NS

# Create a bridge
ip netns exec NS ip link add name br0 type bridge

# Create a veth pair
ip link add NS-veth1 type veth peer name veth0
# Assign the veth interfaces to the network namespaces
ip link set NS-veth1 netns NS
# Assign veth1 to br0
ip netns exec NS ip link set NS-veth1 master br0

# Assign IP addresses to the veth0 interfaces
ip addr add 172.27.100.2/24 dev veth0

# Eth0 to NS
ip link set eth0 netns NS
# Assign eth0 to br0
ip netns exec NS ip link set eth0 master br0

# Bring up the veth interfaces
ip netns exec NS ip link set eth0 up
ip netns exec NS ip link set br0 up
ip netns exec NS ip link set NS-veth1 up
ip link set veth0 up


# Create a network namespace
ip netns add NS1
ip netns add NS2

# Create a veth pair
ip link add NS1-veth0 type veth peer name NS2-veth0
# Assign the veth interfaces to the network namespaces
ip link set NS1-veth0 netns NS1
ip link set NS2-veth0 netns NS2
ip link show
ip netns exec NS1 ip link show
ip netns exec NS2 ip link show

# Assign IP addresses to the veth interfaces
ip netns exec NS1 ip address add 192.0.2.1/24 dev NS1-veth0
ip netns exec NS2 ip address add 192.0.2.2/24 dev NS2-veth0

# Bring up the veth interfaces
ip netns exec NS1 ip link set NS1-veth0 up
ip netns exec NS2 ip link set NS2-veth0 up

#
ip netns exec NS1 ping -c 3 192.0.2.2
ip netns exec NS2 ping -c 3 192.0.2.1

ip netns exec NS1 ping -c 3 192.0.2.2 -I 192.0.2.1
ip netns exec NS1 ping -c 3 192.0.2.1 -I 192.0.2.2

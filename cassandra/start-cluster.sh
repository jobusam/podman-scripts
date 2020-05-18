#!/bin/bash

echo "Start a Cassandra cluster with three nodes in two different data centers"
echo "To create a Cassandra cluster on a local host every container must have their own ip."
echo "Therefore it's necessary to execute the images with root to add them to the podman network (networking as non-root user is not allowed"

sudo podman run --name=node1 -d \
-e CASSANDRA_DC=DC1 -e CASSANDRA_RACK=RAC1 \
-e CASSANDRA_ENDPOINT_SNITCH=GossipingPropertyFileSnitch cassandra

NODE1_IP=`sudo podman inspect -f "{{.NetworkSettings.IPAddress}}" node1`

sudo podman run --name=node2 -d \
-e CASSANDRA_DC=DC1 -e CASSANDRA_RACK=RAC2 \
-e CASSANDRA_ENDPOINT_SNITCH=GossipingPropertyFileSnitch \
-e CASSANDRA_SEEDS=$NODE1_IP cassandra

podman run --name=node3 -d \
-e CASSANDRA_DC=DC2 -e CASSANDRA_RACK=RAC1 \
-e CASSANDRA_ENDPOINT_SNITCH=GossipingPropertyFileSnitch \
-e CASSANDRA_SEEDS=$NODE1_IP cassandra

# 1) Check the status of all three nodes with:
#    $ podman exec -it node1 nodetool status

# 2) Execute Cassandra Query Language Shelle and create a keyspace with different replications
# podman exec -it node1 cqlsh
# # Describe Keyspaces;
# # Create Keyspaces distributed_ks WITH replication = {'class': 'NetworkTopologyStrategy', 'DC1':2, 'DC2':1 };
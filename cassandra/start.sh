#!/bin/bash

echo "Start a cassandra node as single instance"

podman run -d -p 7000:7000 \
--name=cassandra-node cassandra


echo "Check Status with the command: podman exec -it cassandra-node nodetool status"
echo "Open a Cassandra Query Language Shell:"
echo " podman exec -it cassandra-node cqlsh"

#!/bin/bash

echo "Show all python all jupyter processes"
while true
do
    date
    ps aux | grep -i jupyter | grep -iv "grep" | grep -iv "podman"
    sleep 10
done
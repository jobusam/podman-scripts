#!/bin/bash

if [ -z "$1" ]; then
    echo "You have to provide an url that shall be tested like $ ./testssl.sh https://localhost:9090"
    exit 0
fi

echo" Use testssl.sh script to check ssl configuration"
podman run -it --rm drwetter/testssl.sh $1

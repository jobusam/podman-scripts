#!/bin/bash

echo "Start a keycloak server"

podman run -d --rm -p 8080:8080 \
-e KEYCLOAK_USER=admin -e KEYCLOAK_PASSWORD=test-123-w \
--name=keycloak docker.io/jboss/keycloak

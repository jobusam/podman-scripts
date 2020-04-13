#!/bin/bash

EXT_PORT=3000
EXT_DATA_DIR=./workspace

echo "Theia Web IDE  will be started on port $EXT_PORT. Access it with http://localhost:$EXT_PORT"
echo "Kill the container with podman stop theia-ide"

# create data dir on host system if it doesn't exist
if [ ! -d $EXT_DATA_DIR ]; then
    mkdir -p $EXT_DATA_DIR;
    # Fix permission issues. the user within the container is not root! therefore the data dir shuld be writable by others
    # to save files within theia ide.
    chmod o+w $EXT_DATA_DIR;
fi;

# run podman in rootless mode in background 
# use -it instead -d to run theia container in foreground
podman run --rm -d -v $EXT_DATA_DIR:/home/project:Z \
-p $EXT_PORT:3000 \
--name theia-ide theiaide/theia-full

#use theia-java or theia-python to get support only for the specific language 
#(see https://hub.docker.com/r/theiaide/theia-full/tags)

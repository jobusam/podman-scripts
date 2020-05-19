#!/bin/bash

BASE_DIR=$(pwd)

JUPYTER_USER=user
PASSWD=pwd
ENC_PASSWD=$(openssl passwd -1 $PASSWD)

echo "Start a new Jupyter Hub on port http://localhost:8000 and add a user with username=$JUPYTER_USER and pwd=$PASSWD"

# Use following line to limit memory to 4 Gigabytes, swap-memory to 0 Megabytes and deactivate memory swappines for performance tests and memory eating! 
#podman run -it --rm -p 8000:8000 --memory=4g --memory-swap=0m --memory-swappiness=0 \

podman run -it --rm -p 8000:8000 \
-v $BASE_DIR/jupyterhub_config.py:/srv/jupyterhub/jupyterhub_config.py:Z \
-v $BASE_DIR/jupyter_notebook_config.py:/etc/jupyter/jupyter_notebook_config.py:Z \
--name jupyterhub jupyterhub/jupyterhub:1.2 \
/bin/bash -c "
pip3 install notebook &&
useradd -m -p '$ENC_PASSWD' $JUPYTER_USER &&
jupyterhub -f /srv/jupyterhub/jupyterhub_config.py"




# The current default jupyterhub config is empty but you can generate a default config file with all commented options
# Therefore run the container with following command:
# $ podman run -it jupyterhub/jupyterhub:1.2 /bin/bash -c "jupyterhub --generate-config && cat jupyterhub_config.py" > jupyterhub_config.py.original
# Afterwards the content is stored in jupyterhub_config.py.original in the current folder

#!/bin/bash

BASE_DIR=$(pwd)

JUPYTER_USER=user
PASSWD=pwd
ENC_PASSWD=$(openssl passwd -1 $PASSWD)

echo "Start a new Jupyter Hub with Hive ODBC Driver 2.6.1 on port http://localhost:8000 and add a user with username=$JUPYTER_USER and pwd=$PASSWD"
echo "Check ODBC Connection with isql -v hive [user] [password]"

podman run -it -p 8000:8000 \
-v $BASE_DIR/src/hive-odbc-2.6.1/:/root/hive-odbc/:Z \
-v $BASE_DIR/jupyterhub_config.py:/etc/jupyterhub_config.py:Z \
--name jupyterhub fedora:latest \
/bin/bash -c "
dnf install -y unixODBC &&
dnf install -y /root/hive-odbc/ClouderaHiveODBC-2.6.1.1001-1.x86_64.rpm &&
dnf install -y python3-pip nodejs &&
dnf install -y g++ python3-devel unixODBC-devel &&
pip3 install jupyterhub notebook pandas pyodbc && 
npm install -g configurable-http-proxy && 
cp /root/hive-odbc/odbc.ini /etc/odbc.ini
useradd -m -p '$ENC_PASSWD' $JUPYTER_USER &&
jupyterhub -f /etc/jupyterhub_config.py"

# The packages g++ python3-devel unixODBC-devel are necessary to build the python package pyodbc that acesses unixODBC to use
# the hive ODBC Driver for connecting to Hive

# For debugging ODBC
# cp /root/hive-odbc/cloudera.hiveodbc.ini /opt/cloudera/hiveodbc/lib/64/

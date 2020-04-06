#!/bin/bash

HOST=localhost
EXT_PORT=2021
EXT_DATA_DIR=./ftp-data
# TODO: OVERWRITE user credentials
FTP_USER=user1
FTP_USER_PWD='test-1234#'
FTP_USER_HOME=/home/$FTP_USER

# Enable TLS.
# See also https://download.pureftpd.org/pub/pure-ftpd/doc/README.TLS
# and https://github.com/stilliard/docker-pure-ftpd/blob/master/run.sh
# Use TLS mode 3 if TLS encryption shall be required for all sessions. You can use FileZilla to connect to ftp via SSL.
TLS_FLAG="--tls=3"

# Disable TLS
# TLS_FLAG=""

echo "FTP will be started on $HOST on port $EXT_PORT ( ftp $HOST $EXT_PORT ) in foreground (use podman in rootless mode)"
echo "User = $FTP_USER , pwd = $FTP_USER_PWD"
echo "This ftp server allows up to 3 clients/connections and 30 passive ports in parellel."
echo "The data will be visible on Host System in folder $EXT_DATA_DIR."
echo 'Use "$ buildah unshare" if you want to access the data on the host system'
echo 'For debugging use $podman exec -it ftp /bin/bash -c "tail -f /var/log/messages"'
echo "Kill the container with CTL+C"

# create data dir on host system if it doesn't exist
if [ ! -d $EXT_DATA_DIR ]; then
    mkdir -p $EXT_DATA_DIR;
fi;

# use -d instead -it to run ftp in background
podman run --rm -it -v $EXT_DATA_DIR:$FTP_USER_HOME:Z \
-p $EXT_PORT:21 -p 30000-30030:30000-30030 \
-e FTP_PASSIVE_PORTS=30000:30030 \
-e FTP_MAX_CLIENTS=3 -e FTP_MAX_CONNECTIONS=3 \
-e FTP_USER_NAME=$FTP_USER -e FTP_USER_PASS=$FTP_USER_PWD -e FTP_USER_HOME=$FTP_USER_HOME \
-e "PUBLICHOST=$HOST" \
-e TLS_CN=$HOST -e TLS_ORG=TEST-FTP -e TLS_C=DE \
-e "ADDED_FLAGS=--verboselog $TLS_FLAG" \
--name ftp stilliard/pure-ftpd:hardened

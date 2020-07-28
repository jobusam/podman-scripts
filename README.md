# podman-scripts
This repository contains several script to setup podman instances like sftp/ftp server, 
jupyter notebooks, mqtt instances, kali instances for security tests, ...

- [FTP-Server](ftp/runFTPServer.sh) with local Data directory on localhost:2021
- [TLS-Test](ssl/testssl.sh) tests HTTPs endpoints and lists TLS version, cipher suites and other information
- [Theia-IDE](theia/runTheiaIDE.sh) with local directory on localhost:3000 an pre-installed plugins
- [Cassandra-Standalone](cassandra/start.sh) as single instance for testing
- [Cassandra-Cluster](cassandra/start-cluster.sh) as cluster with 3 nodes. This works only with root privileges because the nodes requires separate IPs.
- [Standard JupyterHub](jupyter/jupyter-standard/start.sh) with an own user
- [Hive ODBC JupyterHub](jupyter/jupyter-odbc/start.sh) with own user and
thirdparty software to access Apache Hive (within an Hadoop Cluster) via Hive Server 2 and Cloudera Hive ODBC driver. See also [README.md](jupyter/jupyter-odbc/README.md).
- [Jupyter Notebook Server with Spark Magic](jupyter/jupyter-sparkmagic/start.sh) to access a Apache Spark Standalone Cluster via Apache Livy
- [Keycloak Server](keycloak/start.sh) for identity and access management

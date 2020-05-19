# JupyterHub with Cloudera Hive ODBC Connector 2.6.1

- Download the Driver: https://www.cloudera.com/downloads/connectors/hive/odbc/2-6-1.html
- OS = Linux, Version 64 bit
- Locate the rpm in the folder src/hive-odbc-2.6.1/  with the name ClouderaHiveODBC-2.6.1.1001-1.x86_64.rpm
- Optional: Afterwards configure the src/hive-odbc-2.6.1/odbc.ini and add the ip/hostname of the Hive Server 2
  This is only necessary if don't want to configure the Host IP directly in Python Notebook. See also [AccessHiveDatabase.ipynb](AccessHiveDatabase.ipynb).
- Now start the script `$ ./start.sh`
- You can import the Jupyter-Notebook [AccessHiveDatabase.ipynb](AccessHiveDatabase.ipynb) to see an example how to access hive via odbc with PyODBC.

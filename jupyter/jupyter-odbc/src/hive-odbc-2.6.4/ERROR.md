# Cloudera Hive ODBC Connector 2.6.4

- Download the Driver: https://www.cloudera.com/downloads/connectors/hive/odbc/2-6-4.html
- OS = Linux, Version 64 bit
- Locate the rpm in this folder with the name ClouderaHiveODBC-2.6.4.1004-1.x86_64.rpm
- Afterwards configure the start.sh script to use version 2.6.4

## ERROR mit Version 2.6.4

With this version of Hive ODBC the "libcrypto" is used in the driver.
But the usage of this lib requires openssl in version 1.1.1.b. This version can't be
downloaded via dnf because there are only the lates openssl libs available. Because of this
stupid bug the ODBC driver in version 2.6.4 is not usable! 
```
# Find missing dependencies in lib
ldd /opt/cloudera/hiveodbc/lib/64/libclouderahiveodbc64.so | grep -i not
```

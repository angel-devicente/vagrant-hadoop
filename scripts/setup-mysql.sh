#!/bin/bash
source "/vagrant/scripts/common.sh"

set -x
echo "############## Setting-up MySQL"
apt-get -qq install -y mysql-server > /dev/null

mysql -e "create user 'hiveuser'@'%' identified by 'hive'"
mysql -e "GRANT ALL ON *.* TO 'hiveuser'@'%' identified by 'hive'"
echo "bind-address=0.0.0.0" >> /etc/my.cnf

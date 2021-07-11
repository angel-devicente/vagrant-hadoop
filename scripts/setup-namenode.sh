#!/bin/bash
source "/vagrant/scripts/common.sh"

echo "############## Setting-up NameNode and DataNodes"

$HADOOP_HOME/bin/hdfs namenode -format myhadoop
$HADOOP_HOME/bin/hdfs --config $HADOOP_CONF_DIR --daemon start namenode
$HADOOP_HOME/bin/hdfs --config $HADOOP_CONF_DIR --daemon start --workers datanode

# when running mapred streaming, if this is not done, the logs directory is owned by root
#  and I get some permission errors. Hopefully this will fix it.
mkdir -p /usr/local/hadoop/logs
chown -R vagrant:vagrant /usr/local/hadoop/logs

# Run yarn daemons in node2
echo "############## Setting-up YARN"
ssh node2 bash /vagrant/scripts/setup-yarn.sh

# Start spark daemons in node1. Please comment out if you don't need spark in the cluster
echo "############## Starting Spark in the cluster"
$SPARK_HOME/sbin/start-all.sh

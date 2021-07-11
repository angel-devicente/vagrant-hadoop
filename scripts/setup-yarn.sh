#!/bin/bash
source "/vagrant/scripts/common.sh"
source /etc/profile.d/hadoop.sh

$HADOOP_YARN_HOME/bin/yarn --config $HADOOP_CONF_DIR --daemon start resourcemanager
$HADOOP_YARN_HOME/bin/yarn --config $HADOOP_CONF_DIR --daemon start --workers nodemanager
$HADOOP_YARN_HOME/bin/yarn --config $HADOOP_CONF_DIR --daemon start proxyserver
$HADOOP_HOME/bin/mapred --config $HADOOP_CONF_DIR --daemon start historyserver

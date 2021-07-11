#!/bin/bash
source "/vagrant/scripts/common.sh"

function installJava {
	echo "install open jdk"
	apt-get -qq install -y openjdk-8-jdk-headless > /dev/null
}

function setupJava {
	echo "setting up javac"
}

function setupEnvVars {
	echo "creating java environment variables"
	echo export CLASSPATH=`hadoop classpath`:$CLASSPATH >> /etc/profile.d/java.sh
}

echo "############## Setting-up javac"
installJava
setupJava
setupEnvVars

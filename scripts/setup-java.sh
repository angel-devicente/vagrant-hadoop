#!/bin/bash
source "/vagrant/scripts/common.sh"

function installJava {
	echo "install open jdk"
	apt-get -qq install -y openjdk-8-jre-headless > /dev/null
}

function setupJava {
	echo "setting up java"
	ln -s /usr/lib/jvm/java-1.8.0-openjdk-amd64/jre /usr/local/java
}

function setupEnvVars {
	echo "creating java environment variables"
	echo export JAVA_HOME=/usr/local/java >> /etc/profile.d/java.sh
	echo export PATH=\${JAVA_HOME}/bin:\${PATH} >> /etc/profile.d/java.sh
}

echo "############## Setting-up Java"
installJava
setupJava
setupEnvVars

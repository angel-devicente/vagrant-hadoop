#!/bin/bash
# http://unix.stackexchange.com/questions/59003/why-ssh-copy-id-prompts-for-the-local-user-password-three-times
# http://linuxcommando.blogspot.com/2008/10/how-to-disable-ssh-host-key-checking.html
# http://linuxcommando.blogspot.ca/2013/10/allow-root-ssh-login-with-public-key.html
# http://stackoverflow.com/questions/12118308/command-line-to-execute-ssh-with-password-authentication
# http://www.cyberciti.biz/faq/noninteractive-shell-script-ssh-password-provider/
source "/vagrant/scripts/common.sh"
START=3
TOTAL_NODES=2

while getopts s:t: option
do
	case "${option}"
	in
		s) START=${OPTARG};;
		t) TOTAL_NODES=${OPTARG};;
	esac
done
#echo "total nodes = $TOTAL_NODES"

function installSSHPass {
    apt-get -qq install -y sshpass > /dev/null
}

function createSSHKey {
	echo "generating ssh key"
	ssh-keygen -t rsa -P "" -f /root/.ssh/id_rsa
	cat /root/.ssh/id_rsa.pub >> /root/.ssh/authorized_keys
	cp -f $RES_SSH_CONFIG /root/.ssh
}

function sshCopyId {
    echo "copying root public key"
    cp /root/.ssh/id_rsa.pub /vagrant/
    for i in $(seq $START $TOTAL_NODES)
    do
	node="node${i}"
	echo "adding ssh key to authorized keys in ${node}"
	sshpass -p 'vagrant' ssh vagrant@${node} "sudo sh -c 'mkdir -p /root/.ssh' "
	sshpass -p 'vagrant' ssh vagrant@${node} "sudo sh -c 'cat /vagrant/id_rsa.pub >> /root/.ssh/authorized_keys' "
    done
    rm  /vagrant/id_rsa.pub 
}

echo "############## Setting-up SSH"
installSSHPass
createSSHKey
sshCopyId

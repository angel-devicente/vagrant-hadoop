#!/bin/bash
source "/vagrant/scripts/common.sh"

# in Ubuntu all traffic is allow by default, so no need to disable the firewall

echo "############## Setting-up Ubuntu Bionic"

apt-get -qq update > /dev/null

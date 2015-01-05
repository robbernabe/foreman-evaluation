#!/bin/bash
#
# Setup puppet on virtual machine. If it's already installed, remove and install from puppet repo.

if [ "$EUID" -ne "0" ]; then
  echo "This script must be run as root." >&2
  exit 1
fi

if dpkg -l | grep puppet > /dev/null 2>&1; then
    sudo apt-get --purge autoremove puppet -yqq
    wget http://apt.puppetlabs.com/puppetlabs-release-precise && \
        sudo dpkg -i puppetlabs-release-precise
    sudo apt-get update && sudo apt-get install puppet -yqq
else
    wget http://apt.puppetlabs.com/puppetlabs-release-precise && \
        sudo dpkg -i puppetlabs-release-precise
    sudo apt-get update && sudo apt-get install puppet -yqq
fi

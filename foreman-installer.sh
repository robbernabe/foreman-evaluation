#!/bin/bash -e

# Fix the hostname problem
sed -i '/127.0.1.1/d' /etc/hosts
echo foreman.local > /proc/sys/kernel/hostname

# Install foreman
apt-get update -q && apt-get install -q -y wget
wget --quiet -O /tmp/p.deb https://apt.puppetlabs.com/puppetlabs-release-precise && dpkg -i /tmp/p.deb
echo "deb http://deb.theforeman.org/ precise 1.7" > /etc/apt/sources.list.d/foreman.list
echo "deb http://deb.theforeman.org/ plugins 1.7" >> /etc/apt/sources.list.d/foreman.list
wget --quiet http://deb.theforeman.org/pubkey.gpg -O- | apt-key add -
apt-get update -q && apt-get install -q -y foreman-installer

FACTER_fqdn=foreman.local /usr/sbin/foreman-installer --foreman-admin-username=admin --foreman-admin-password=admin

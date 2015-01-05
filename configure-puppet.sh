#!/bin/bash -e

sed -i 's/START=no/START=yes/' /etc/default/puppet
/usr/bin/puppet config set environment production
/usr/bin/puppet config set server foreman.local
/usr/bin/puppet resource service puppet ensure=running enable=true

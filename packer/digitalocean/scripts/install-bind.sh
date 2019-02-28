#!/usr/bin/env bash

ufw allow from 10.132.67.194/16 to any port 53

apt-get install -y bind9 bind9utils bind9-doc

mv /tmp/named.conf.local /etc/bind/named.conf.local
mv /tmp/named.conf.options /etc/bind/named.conf.options
mv /tmp/db.int.do.ddreier.com /var/lib/bind/db.int.do.ddreier.com
mv /tmp/db.132.10 /var/lib/bind/db.132.10

#perl -i -p0e "s/(nameservers: &id001\n\s+addresses:)\n\s+-.+\n\s+-.+/\1 [ '127.0.0.1' ]/g" /etc/netplan/50-cloud-init.yaml
#perl -i -p0e 's/(search:) \[\]/\1 [ 'int.do.ddreier.com' ]/g' 50-cloud-init.yaml
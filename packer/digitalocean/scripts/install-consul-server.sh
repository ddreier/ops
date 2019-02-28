#!/usr/bin/env bash

echo DNS=10.132.37.100 >> /etc/systemd/resolved.conf
echo Domains=int.do.ddreier.com. >> /etc/systemd/resolved.conf

ufw allow from 10.132.67.194/16 to any port 8300
ufw allow from 10.132.67.194/16 to any port 8301
ufw allow from 10.132.67.194/16 to any port 8302
ufw allow from 10.132.67.194/16 to any port 8500
ufw allow from 10.132.67.194/16 to any port 8501
ufw allow from 10.132.67.194/16 to any port 8502
ufw allow from 10.132.67.194/16 to any port 8600

useradd -r consul

mkdir -p /etc/consul.d/

mkdir /var/consul
chown consul:consul /var/consul

mv /tmp/consul.json /etc/consul.d/consul.json
mv /tmp/consul.service /etc/systemd/system/consul.service

systemctl daemon-reload
systemctl enable consul
#!/usr/bin/env bash

sudo useradd -r consul

sudo mkdir -p /etc/consul.d/

sudo mkdir /var/consul
sudo chown consul:consul /var/consul

sudo mv /tmp/consul.json /etc/consul.d/consul.json
sudo mv /tmp/consul.service /etc/systemd/system/consul.service

sudo systemctl daemon-reload
#sudo systemctl enable consul
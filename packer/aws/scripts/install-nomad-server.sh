#!/usr/bin/env bash

###################
#   SETUP NOMAD   #
###################
sudo mkdir -p /var/lib/nomad
sudo mkdir -p /etc/nomad

sudo mv /tmp/nomad.hcl /etc/nomad/nomad.hcl
sudo mv /tmp/nomad.service /etc/systemd/system/nomad.service

sudo systemctl daemon-reload
#sudo systemctl enable nomad

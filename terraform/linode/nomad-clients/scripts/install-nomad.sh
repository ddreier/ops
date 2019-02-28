#!/usr/bin/env bash

NOMAD_VERSION=0.8.7

wget -O /tmp/nomad.zip https://releases.hashicorp.com/nomad/${NOMAD_VERSION}/nomad_${NOMAD_VERSION}_linux_amd64.zip
unzip /tmp/nomad.zip -d /usr/local/bin/

mkdir /etc/nomad
mv /tmp/nomad.hcl /etc/nomad/

# Set up the Nomad SystemD service
systemctl daemon-reload
systemctl enable nomad
systemctl start nomad
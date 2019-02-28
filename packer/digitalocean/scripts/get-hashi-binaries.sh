#!/usr/bin/env bash

TOOLS=()

wget -nv -O /tmp/nomad.zip https://releases.hashicorp.com/nomad/0.8.7/nomad_0.8.7_linux_amd64.zip; TOOLS+=(nomad)
wget -nv -O /tmp/consul.zip https://releases.hashicorp.com/consul/1.4.2/consul_1.4.2_linux_amd64.zip; TOOLS+=(consul)
wget -nv -O /tmp/terraform.zip https://releases.hashicorp.com/terraform/0.11.11/terraform_0.11.11_linux_amd64.zip; TOOLS+=(terraform)
wget -nv -O /tmp/packer.zip https://releases.hashicorp.com/packer/1.3.4/packer_1.3.4_linux_amd64.zip; TOOLS+=(packer)

for tool in ${TOOLS[*]}; do
    unzip /tmp/$tool.zip -d /usr/local/bin/
    rm /tmp/$tool.zip
done

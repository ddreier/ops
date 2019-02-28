.PHONY: all
all: base bastion consul-server nomad-server nomad-client rabbitmq

.PHONY: base
base: base.manifest

base.manifest: base.json scripts/base.sh scripts/get-hashi-binaries.sh scripts/install-consul-client.sh files/consul-client/consul.json files/consul-client/consul.json
	packer validate base.json
	packer build base.json

.PHONY: bastion
bastion: bastion.manifest

bastion.manifest: base.manifest bastion.json scripts/bastion.sh
	packer validate bastion.json
	packer build bastion.json

.PHONY: consul-server
consul-server: consul-server.manifest

consul-server.manifest: base.manifest consul-server.json scripts/install-consul-server.sh files/consul-server/consul.json files/consul-server/consul.service
	packer validate consul-server.json
	packer build consul-server.json

.PHONY: nomad-server
nomad-server: nomad-server.manifest

nomad-server.manifest: base.manifest nomad-server.json scripts/install-nomad-server.sh files/nomad-server/nomad.hcl files/nomad-server/nomad.service
	packer validate nomad-server.json
	packer build nomad-server.json

.PHONY: nomad-client
nomad-client: nomad-client.manifest

nomad-client.manifest: base.manifest nomad-client.json scripts/install-nomad-client.sh files/nomad-client/nomad.hcl files/nomad-client/nomad.service
	packer validate nomad-client.json
	packer build nomad-client.json

.PHONY: rabbitmq
rabbitmq: rabbitmq.manifest

rabbitmq.manifest: base.manifest rabbitmq.json scripts/install-rabbitmq.sh
	packer validate rabbitmq.json
	packer build rabbitmq.json

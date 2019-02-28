.PHONY: all
all: base bastion dns consul-server

.PHONY: base
base: base-ubuntu-1804.manifest

base-ubuntu-1804.manifest: base-ubuntu-1804.json
	packer validate base-ubuntu-1804.json
	packer build base-ubuntu-1804.json

.PHONY: bastion
bastion: bastion.manifest

bastion.manifest: bastion.json base-ubuntu-1804.manifest scripts/get-hashi-binaries.sh
	$(eval image_id = $(shell grep artifact_id base-ubuntu-1804.manifest | tail -n1 | cut -d\" -f4 | cut -d: -f2))
	packer validate -var 'source_image=$(image_id)' bastion.json
	packer build -var 'source_image=$(image_id)' bastion.json

.PHONY: dns
dns: dns.manifest

dns.manifest: bind-dns.json base-ubuntu-1804.manifest files/bind/named.conf.local files/bind/named.conf.options files/bind/zones/db.132.10 files/bind/zones/db.int.do.ddreier.com scripts/install-bind.sh
	$(eval image_id = $(shell grep artifact_id base-ubuntu-1804.manifest | tail -n1 | cut -d\" -f4 | cut -d: -f2))
	packer validate -var 'source_image=$(image_id)' bind-dns.json
	packer build -var 'source_image=$(image_id)' bind-dns.json

.PHONY: consul-server
consul-server: consul-server.manifest

consul-server.manifest: base-ubuntu-1804.manifest files/consul-server-config.json files/consul.service scripts/install-consul-server.sh
	$(eval image_id = $(shell grep artifact_id base-ubuntu-1804.manifest | tail -n1 | cut -d\" -f4 | cut -d: -f2))
	packer validate -var 'source_image=$(image_id)' consul-server.json
	packer build -var 'source_image=$(image_id)' consul-server.json
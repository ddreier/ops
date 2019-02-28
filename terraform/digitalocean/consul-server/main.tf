variable "count" {
  default = 3
}

provider "digitalocean" {
  token = "SUPER SECRET"
}

data "digitalocean_droplet" "dns_droplet" {
  name = "dns"
}

provider "dns" {
  update {
    server = "${data.digitalocean_droplet.dns_droplet.ipv4_address_private}"
  }
}

module "consul-server" {
  source = "../modules/consul-server"
  count = "${var.count}"
}

resource "dns_a_record_set" "consul_server_dns" {
  addresses = [ "${element(module.consul-server.private_ip, count.index)}" ]
  name = "${element(module.consul-server.droplet_name, count.index)}"
  zone = "int.do.ddreier.com."
  count = "${var.count}"
}

resource "dns_a_record_set" "consul_dns" {
  addresses = [ "${module.consul-server.private_ip}" ]
  name = "consul"
  zone = "int.do.ddreier.com."
}

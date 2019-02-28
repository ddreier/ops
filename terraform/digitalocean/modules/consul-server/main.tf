variable "count" {
  default = 3
}

provider "digitalocean" {
  token = "SUPER SECRET"
}

data "digitalocean_droplet_snapshot" "consul_server_snapshot" {
  name_regex = "^consul-server-packer"
  most_recent = true
  region = "nyc3"
}

resource "digitalocean_droplet" "consul_server_droplet" {
  image = "${data.digitalocean_droplet_snapshot.consul_server_snapshot.id}"
  name = "${format("consul-%03d", count.index)}"
  region = "nyc3"
  size = "s-1vcpu-1gb"
  count = "${var.count}"
  private_networking = true
}

output "droplet_name" {
  value = "${digitalocean_droplet.consul_server_droplet.*.name}"
}

output "private_ip" {
  value = "${digitalocean_droplet.consul_server_droplet.*.ipv4_address_private}"
}

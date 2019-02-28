provider "digitalocean" {
  token = "SUPER SECRET"
}

data "digitalocean_ssh_key" "ddreier_caffeine" {
  name = "ddreier@caffeine"
}

data "digitalocean_droplet_snapshot" "bastion_snapshot" {
  name_regex = "^bastion-packer"
  most_recent = true
  region = "nyc3"
}

resource "digitalocean_droplet" "bastion_droplet" {
  image = "${data.digitalocean_droplet_snapshot.bastion_snapshot.id}"
  name = "bastion"
  region = "nyc3"
  size = "s-1vcpu-1gb"
  private_networking = true
//  ssh_keys = [ "${data.digitalocean_ssh_key.ddreier_caffeine.fingerprint}" ]
}

resource "digitalocean_domain" "bastion_domain" {
  name = "bastion.do.ddreier.com"
  ip_address = "${digitalocean_droplet.bastion_droplet.ipv4_address}"
}

output "private_ip" {
  value = "${digitalocean_droplet.bastion_droplet.ipv4_address_private}"
}
provider "digitalocean" {
  token = "SUPER SECRET"
}

provider "dns" {
  update {
    server = "${digitalocean_droplet.dns_droplet.ipv4_address_private}"
  }
}

data "digitalocean_ssh_key" "ddreier_caffeine" {
  name = "ddreier@caffeine"
}

data "digitalocean_droplet_snapshot" "dns_snapshot" {
  name_regex = "^dns-packer"
  most_recent = true
  region = "nyc3"
}

resource "digitalocean_droplet" "dns_droplet" {
  image = "${data.digitalocean_droplet_snapshot.dns_snapshot.id}"
  name = "dns"
  region = "nyc3"
  size = "s-1vcpu-1gb"
  private_networking = true
//  ssh_keys = [ "${data.digitalocean_ssh_key.ddreier_caffeine.fingerprint}" ]
}

//resource "dns_a_record_set" "dns" {
//  zone = "int.do.ddreier.com."
//  name = "dns"
//  addresses = [
//    "${digitalocean_droplet.dns_droplet.ipv4_address_private}"
//  ]
//}

output "private_ip" {
  value = "${digitalocean_droplet.dns_droplet.ipv4_address_private}"
}

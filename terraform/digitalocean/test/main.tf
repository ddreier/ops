provider "digitalocean" {
  token = "SUPER SECRET"
}

resource "digitalocean_droplet" "test_droplet" {
  image = "43692538"
  name = "test"
  region = "nyc3"
  size = "s-1vcpu-1gb"
}

resource "digitalocean_domain" "test" {
  name = "test.do.ddreier.com"
  ip_address = "${digitalocean_droplet.test_droplet.ipv4_address}"
}
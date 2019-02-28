provider "digitalocean" {
  token = "SUPER SECRET"
}
provider "dns" {
  update {
    server = "${module.dns.private_ip}"
  }
}

data "digitalocean_droplet" "bastion" {
  name = "bastion"
}

module "dns" {
  source = "../dns"
}

//module "bastion" {
//  source = "../bastion"
//}

resource "dns_a_record_set" "dns_dns_a" {
  addresses = [ "${module.dns.private_ip}" ]
  name = "dns"
  zone = "int.do.ddreier.com."
  provisioner "local-exec" {
    command = "sleep 15"
  }
}

resource "dns_a_record_set" "bastion_dns_a" {
  addresses = [ "${data.digitalocean_droplet.bastion.ipv4_address_private}" ]
  name = "bastion"
  zone = "int.do.ddreier.com."
}

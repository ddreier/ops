provider "aws" {
  region = "us-east-1"
  access_key = "SUPER SECRET"
  secret_key = "SUPER SECRET"
  profile = "terraform"
}

provider "linode" {
  token = "SUPER SECRET"
}

data "linode_domain" "ddreier_domain" {
  domain = "ddreier.com"
}

module "bastion" {
  source = "../modules/bastion_instance"

  vpc_name = "terraform"
}

resource "linode_domain_record" "bastion_dns" {
  domain_id = "${data.linode_domain.ddreier_domain.id}"
  name = "bastion.aws"
  record_type = "A"
  target = "${module.bastion.ip_addr}"
}

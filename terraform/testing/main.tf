provider "linode" {
  token = "${var.token}"
}

module "db-linode" {
  source = "./modules/database"
  key = "${var.key}"
  key_label = "${var.key_label}"
  image = "${var.image}"
  label = "${var.label}"
  region = "${var.region}"
  type = "${var.type}"
  root_pass = "${var.root_pass}"
  authorized_keys = [ "${module.db-linode.sshkey_linode}" ]
  count = "${var.count}"
}

provider "linode" {
  token = "${var.token}"
}

module "nomad-client-instance" {
  source = "../modules/nomad-client"
  region = "${var.region}"
  image = "${var.image}"
  count = "${var.count}"

  authorized_keys = "${var.authorized_keys}"
  root_pass = "${var.root_pass}"
}

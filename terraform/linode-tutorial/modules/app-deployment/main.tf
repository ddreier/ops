# Web Server
resource "linode_instance" "terraform-web" {
  region = "${var.region}"
  image = "linode/ubuntu18.04"
  label = "${var.webserver_label}"
  group = "Terraform"
  tags = ["terraform", "webserver"]
  type = "g6-standard-1"
  swap_size = 1024
  root_pass = "${var.root_pass}"
}

# Database Server
resource "linode_instance" "terraform-db" {
  region = "${var.region}"
  image = "linode/centos7"
  label = "${var.dbserver_label}"
  group = "Terraform"
  tags = ["terraform", "dbserver"]
  type = "${var.db_type}"
  swap_size = 1024
  root_pass = "${var.root_pass}"
}
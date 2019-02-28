locals {
  key = "${var.key}"
}

resource "linode_sshkey" "main_key" {
  label = "main_ssh_key"
  ssh_key = "${chomp(file(local.key))}"
}

resource "linode_instance" "database" {
  region = "${var.region}"
  label = "${var.label}-${count.index}"
  image = "${var.image}"
  type = "${var.type}"
  authorized_keys = [ "${linode_sshkey.main_key.ssh_key}" ]
  root_pass = "${var.root_pass}"
  tags = [ "terraform", "database" ]

  private_ip = true

  count = "${var.count}"

  provisioner "remote-exec" {
    connection {
      type = "ssh"
      user = "root"
      password = "${var.root_pass}"
    }

    inline = [
      "ln -fs /usr/share/zoneinfo/America/Chicago /etc/localtime",
      "dpkg-reconfigure --frontend noninteractive tzdata",
      "apt update -yq",
      "apt-mark hold grub-pc",
//      "apt upgrade -yq -o Dpkg::Options::=\"--force-confdef\" -o Dpkg::Options::=\"--force-confold\" --force-yes",
      "apt upgrade -yq",
      "apt install -yq mariadb-server postgresql"
    ]
  }
}
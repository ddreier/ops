# Create a Linode Instance for running Nomad jobs

data "linode_profile" "me" {}

//resource "linode_volume" "data_volume" {
//  label = "data_volume"
//  region = "us-central"
//  size = 20
//}

resource "linode_instance" "nomad-client" {
  region = "${var.region}"
//  image = "${var.image}"
  count = "${var.count}"

  label = "${format("nomad-%03d", count.index)}"
  tags = [ "terraform", "nomad" ]

  private_ip = true

  disk {
    label = "boot"
    size = 50000
    image = "linode/ubuntu18.04"

    authorized_keys = "${var.authorized_keys}"
    authorized_users = [ "${data.linode_profile.me.username}" ]
    root_pass = "${var.root_pass}"
  }

  config {
    label = "boot_config"
    kernel = "linode/latest-64bit"
    helpers { network = true }
    devices {
      sda { disk_label = "boot" },
//      sdb { volume_id = "${linode_volume.data_volume.id}" }
    }
    root_device = "/dev/sda"
  }

  boot_config_label = "boot_config"

  provisioner "file" {
    connection {
      type = "ssh"
      user = "root"
      password = "${var.root_pass}"
    }

    source = "../scripts/initial-setup.sh"
    destination = "/tmp/initial-setup.sh"
  }

  provisioner "file" {
    connection {
      type = "ssh"
      user = "root"
      password = "${var.root_pass}"
    }

    source = "scripts/install-nomad.sh"
    destination = "/tmp/install-nomad.sh"
  }

  provisioner "file" {
    connection {
      type = "ssh"
      user = "root"
      password = "${var.root_pass}"
    }

    source = "files/nomad.service"
    destination = "/etc/systemd/system/nomad.service"
  }

  provisioner "file" {
    connection {
      type = "ssh"
      user = "root"
      password = "${var.root_pass}"
    }

    source = "files/nomad-config.hcl"
    destination = "/tmp/nomad.hcl"
  }

  provisioner "remote-exec" {
    connection {
      type = "ssh"
      user = "root"
      password = "${var.root_pass}"
    }

    inline = [
      "hostnamectl set-hostname ${format("nomad-%03d", count.index)}",
      "chmod +x /tmp/initial-setup.sh",
      "chmod +x /tmp/install-nomad.sh",
      "/tmp/initial-setup.sh",
      "/tmp/install-nomad.sh"
    ]
  }
}
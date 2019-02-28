provider "linode" {
  token = "${var.token}"
}

resource "linode_sshkey" "my-ssh-key" {
  label = "my-ssh-key"
  ssh_key = "${chomp(file("~/.ssh/id_rsa.pub"))}"
}
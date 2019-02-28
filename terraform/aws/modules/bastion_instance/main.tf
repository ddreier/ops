data "aws_vpc" "selected" {
  tags {
    Name = "${var.vpc_name}"
  }
}

data "aws_ami" "bastion" {
  most_recent = true

  owners = [ "self" ]

  filter {
    name = "name"
    values = [ "bastion packer-*" ]
  }
}

data "aws_subnet" "selected" {
  vpc_id = "${data.aws_vpc.selected.id}"
  cidr_block = "${cidrsubnet(data.aws_vpc.selected.cidr_block, 8, 0)}"
}

data "aws_security_group" "selected" {
  name = "allow-all-sg"
}

resource "aws_instance" "tf-bastion-instance" {
  ami = "${data.aws_ami.bastion.id}"
  instance_type = "t3.nano"
  key_name = "caffeine"
  subnet_id = "${data.aws_subnet.selected.id}"
  vpc_security_group_ids = [ "${data.aws_security_group.selected.id}" ]

  user_data = <<EOF
#!/usr/bin/env bash

sed -i 's/preserve_hostname: false/preserve_hostname: true/g' /etc/cloud/cloud.cfg
hostnamectl set-hostname bastion
echo 127.0.0.1 bastion > /etc/hosts

systemctl enable consul
systemctl start consul
EOF

  tags {
    Name = "bastion"
  }
}

resource "aws_eip" "tf-bastion-eip" {
  instance = "${aws_instance.tf-bastion-instance.id}"
  vpc = true
}

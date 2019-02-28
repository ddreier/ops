data "aws_vpc" "selected" {
  tags {
    Name = "${var.vpc_name}"
  }
}

data "aws_subnet" "selected" {
  vpc_id = "${data.aws_vpc.selected.id}"
  cidr_block = "${cidrsubnet(data.aws_vpc.selected.cidr_block, 3, 1)}"
}

data "aws_ami" "consul-server" {
  most_recent = true

  owners = [ "self" ]

  filter {
    name = "name"
    values = [ "consul-server packer-*" ]
  }
}

data "aws_security_group" "internal-all-sg" {
  name = "internal-all-sg"
}

resource "aws_instance" "consul-server" {
  ami = "${data.aws_ami.consul-server.id}"
  instance_type = "t3.micro"
  key_name = "caffeine"
  subnet_id = "${data.aws_subnet.selected.id}"

  vpc_security_group_ids = [ "${data.aws_security_group.internal-all-sg.id}" ]

  user_data = <<EOF
#!/usr/bin/env bash

sed -i 's/preserve_hostname: false/preserve_hostname: true/g' /etc/cloud/cloud.cfg
hostnamectl set-hostname consul-${count.index + 1}
echo 127.0.0.1 consul-${count.index + 1} > /etc/hosts

systemctl enable consul
systemctl start consul
EOF

  count = "${var.count}"

  tags {
    Name = "consul-${count.index + 1}"
    consul-join = "consul-join"
  }
}

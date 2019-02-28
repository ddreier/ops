data "aws_vpc" "selected" {
  tags {
    Name = "${var.vpc_name}"
  }
}

data "aws_subnet" "selected" {
  vpc_id = "${data.aws_vpc.selected.id}"
  cidr_block = "${cidrsubnet(data.aws_vpc.selected.cidr_block, 3, 1)}"
}

data "aws_ami" "nomad-client" {
  most_recent = true

  owners = [ "self" ]

  filter {
    name = "name"
    values = [ "nomad-client packer-*" ]
  }
}

data "aws_security_group" "internal-all-sg" {
  name = "internal-all-sg"
}

resource "aws_instance" "nomad-client" {
  ami = "${data.aws_ami.nomad-client.id}"
  instance_type = "t3.small"
  key_name = "caffeine"
  subnet_id = "${data.aws_subnet.selected.id}"

  vpc_security_group_ids = [ "${data.aws_security_group.internal-all-sg.id}" ]

  user_data = <<EOF
#!/usr/bin/env bash

sed -i 's/preserve_hostname: false/preserve_hostname: true/g' /etc/cloud/cloud.cfg
hostnamectl set-hostname nomad-client-${count.index + 1}
echo 127.0.0.1 nomad-client-${count.index + 1} > /etc/hosts

systemctl enable consul
systemctl enable nomad
systemctl start consul
systemctl start nomad
EOF

  count = "${var.count}"

  tags {
    Name = "nomad-client-${count.index + 1}"
    nomad-join = "nomad-join"
  }
}

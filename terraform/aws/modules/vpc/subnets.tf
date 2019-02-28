resource "aws_subnet" "tf-subnet-internal" {
  cidr_block = "${cidrsubnet(aws_vpc.tf_vpc.cidr_block, 3, 1)}"
  vpc_id = "${aws_vpc.tf_vpc.id}"
  tags {
    Name = "internal"
  }
}

resource "aws_route_table" "tf-internal-route-table" {
  vpc_id = "${aws_vpc.tf_vpc.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_nat_gateway.tf-nat-gw.id}"
  }

  tags {
    Name = "tf-env-route-table"
  }
}

resource "aws_route_table_association" "tf-int-sub-assoc" {
  route_table_id = "${aws_route_table.tf-internal-route-table.id}"
  subnet_id = "${aws_subnet.tf-subnet-internal.id}"
}

resource "aws_subnet" "tf-subnet-bastion" {
  cidr_block = "${cidrsubnet(aws_vpc.tf_vpc.cidr_block, 8, 0)}"
  vpc_id = "${aws_vpc.tf_vpc.id}"
  tags {
    Name = "bastion"
  }
}

resource "aws_route_table" "tf-bastion-route-table" {
  vpc_id = "${aws_vpc.tf_vpc.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.tf-env-gw.id}"
  }

  tags {
    Name = "tf-env-route-table"
  }
}

resource "aws_route_table_association" "tf-bastion-sub-assoc" {
  route_table_id = "${aws_route_table.tf-bastion-route-table.id}"
  subnet_id = "${aws_subnet.tf-subnet-bastion.id}"
}

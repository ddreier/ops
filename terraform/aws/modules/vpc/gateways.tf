resource "aws_internet_gateway" "tf-env-gw" {
  vpc_id = "${aws_vpc.tf_vpc.id}"

  tags {
    Name = "tf-env-gw"
  }
}

resource "aws_nat_gateway" "tf-nat-gw" {
  allocation_id = "${aws_eip.tf-nat-eip.id}"
  subnet_id = "${aws_subnet.tf-subnet-bastion.id}"
}

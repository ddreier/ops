resource "aws_security_group" "ingress-all-ssh" {
  name = "allow-all-sg"

  vpc_id = "${aws_vpc.tf_vpc.id}"

  ingress {
    cidr_blocks = [ "0.0.0.0/0" ]
    from_port = 22
    to_port = 22
    protocol = "tcp"
  }
  egress {
    cidr_blocks = [ "0.0.0.0/0" ]
    from_port = 0
    to_port = 0
    protocol = "-1"
  }
}

resource "aws_security_group" "internal-all-sg" {
  name = "internal-all-sg"

  vpc_id = "${aws_vpc.tf_vpc.id}"

  ingress {
    cidr_blocks = ["10.0.0.0/16"]
    from_port = 0
    protocol = "-1"
    to_port = 0
  }

  egress {
    cidr_blocks = [ "0.0.0.0/0" ]
    from_port = 0
    protocol = "-1"
    to_port = 0
  }
}
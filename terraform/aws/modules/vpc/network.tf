resource "aws_vpc" "tf_vpc" {
  cidr_block = "10.0.0.0/16"

  tags {
    Name = "terraform"
  }
}

resource "aws_vpc_dhcp_options" "tf-dhcp-options" {
  domain_name = "int.aws.ddreier.com"
  domain_name_servers = [ "AmazonProvidedDNS" ]
}

resource "aws_vpc_dhcp_options_association" "tf-dhcp-options-assoc" {
  dhcp_options_id = "${aws_vpc_dhcp_options.tf-dhcp-options.id}"
  vpc_id = "${aws_vpc.tf_vpc.id}"
}

resource "aws_eip" "tf-nat-eip" {
  vpc = true
}

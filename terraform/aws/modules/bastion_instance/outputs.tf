output "ip_addr" {
  value = "${aws_eip.tf-bastion-eip.public_ip}"
}
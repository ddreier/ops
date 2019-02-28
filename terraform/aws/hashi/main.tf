provider "aws" {
  region = "us-east-1"
  access_key = "SUPER SECRET"
  secret_key = "SUPER SECRET"
  profile = "terraform"
}

module "consul-server" {
  source = "../modules/consul-server"

  vpc_name = "terraform"

  count = "3"
}

module "nomad-server" {
  source = "../modules/nomad-server"

  vpc_name = "terraform"

  count = "3"
}

module "nomad-client" {
  source = "../modules/nomad-client"

  vpc_name = "terraform"

  count = "0"
}

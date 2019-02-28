provider "aws" {
  region = "us-east-1"
  access_key = "SUPER SECRET"
  secret_key = "SUPER SECRET"
  profile = "terraform"
}

provider "consul" {}

module "rabbitmq" {
  source = "../modules/rabbitmq"

  vpc_name = "terraform"
}

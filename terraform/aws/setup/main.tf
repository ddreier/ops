provider "aws" {
  region = "us-east-1"
  access_key = "SUPER SECRET"
  secret_key = "SUPER SECRET"
  profile = "terraform"
}

module "vpc" {
  source = "../modules/vpc"

  vpc_name = "terraform"
}

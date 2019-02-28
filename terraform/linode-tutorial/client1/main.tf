provider "linode" {
  token = "SUPER SECRET"
}

module "app-deployment" {
  source = "../modules/app-deployment"

  # Variables for this deployment
  region = "us-east"
  root_pass = "supersecurerootpassword!"

  # Variables specific to servers
  webserver_label = "client1-web"
  dbserver_label = "client1-db"
  db_type = "g6-standard-4"
}

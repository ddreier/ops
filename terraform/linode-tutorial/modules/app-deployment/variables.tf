variable "webserver_label" {
  description = "The name for the Web Server"
  default = "default-web"
}

variable "dbserver_label" {
  description = "The name for the Database Server"
  default = "default-db"
}

variable "db_type" {
  description = "The size (plan) for your Database Linode"
  default = "g6-standard-1"
}

variable "region" {
  description = "The default Linode region"
  default = "us-central"
}

variable "root_pass" {
  description = "The default root password"
  default = "r00tr00t!"
}

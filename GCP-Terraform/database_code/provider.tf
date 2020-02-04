variable "path" {default = "/home/vagrant/Projects/credentials/"}


provider "google" {
   project = "developmet" 
   region = "us-west1"
   credentials = "${file("${var.path}/secrets.json")}"
}
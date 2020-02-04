variable "path" {default = "/home/vagrant/Projects/credentials/"}


provider "google" {
   project = "developmet" 
   region = "us-west2-a"
   credentials = "${file("${var.path}/secrets.json")}"
}
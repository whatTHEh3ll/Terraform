variable "path" {default = "/home/vagrant/Projects/GCP-Terraform/credentials"}


provider "google" {
   project = "developmet" 
   region = "us-west1"
   credentials = "${file("${var.path}/secrets.json")}"
}
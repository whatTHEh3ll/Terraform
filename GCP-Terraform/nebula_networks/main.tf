# This is the provider used to spin up the gcloud instance
provider "google" {
  project = var.project_name
  region  = var.region_name
  zone    = var.zone_name
  credentials = "/home/vagrant/Projects/credentials/secrets.json"
}

# Locks the version of Terraform for this particular use case
terraform {
  required_version = "~>0.12.0"
}

# This creates the google instance
resource "google_compute_instance" "vm_instance" {
  name         = "terraform-instance"
  machine_type = var.machine_size

   tags = ["allow-http", "allow-https", "allow-dns"]  # FIREWALL

  boot_disk {
    initialize_params {
      image = var.image_name
    }
  }

  network_interface {
    network       = "default"
    # Associated our public IP address to this instance
    access_config {
      nat_ip = google_compute_address.static.address
    }
  }

# We connect to our instance via Terraform and remotely executes our script using SSH
  provisioner "remote-exec" {
    script = var.script_path

    connection {
      type        = "ssh"
      host        = google_compute_address.static.address
      user        = var.username
      private_key = file(var.private_key_path)
    }
  }
}

# We create a public IP address for our google compute instance to utilize
resource "google_compute_address" "static" {
  name = "vm-public-address"
}

locals {
   name = "list-${var.name1}-${var.name2}-${var.name3}"
}



resource "google_compute_instance" "default" {
count = "${var.machine_count}"
name = "${local.name}"
machine_type = "${var.machine_type}"
zone = "${var.zone}"
can_ip_forward = "false"
description = "This is our Virtual Machine"

    tags = ["allow-http", "allow-https", "allow-dns"]  # FIREWALL

boot_disk {
    initialize_params {
        image = "${var.image}"
        size  = "20"
    }
 }

labels = {
    name = "list-${count.index+1}"
    machine_type = "${var.environment != "dev" ? var.machine_type : var.machine_type_dev}"
}

network_interface {
    network = "default"
    access_config {
    #Ephemeral IP - leaving this block empty will generate a new external IP and assign it to the machine
    }
 }

metadata = {
    size = "20"
    foo = "bar"
}

metadata_startup_script = "/home/coney/vagrant-boxes/Terraform/Projects/GCP-Terraform/virtual_machine/scripts/startup_script.sh"

service_account {
    scopes = ["userinfo-email", "compute-ro", "storage-ro"]
 }
  
}

resource "google_compute_disk" "default" {
    name = "test-desk"
    type = "pd-ssd"
    zone = "us-west1-a"
    size = "10"
}

resource "google_compute_attached_disk" "default" {
    disk = "${google_compute_disk.default.self_link}"
    instance = "${google_compute_instance.default[0].self_link}"
}
 
output "machine_type" { value = "${google_compute_instance.default.*.machine_type}" }
output "name" { value = "${google_compute_instance.default.*.name}" }
output "zone" { value = "${google_compute_instance.default.*.zone}" }


#output "instance_id" { value = "${join(",",google_compute_instance.default.*.id)}"}
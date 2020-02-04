variable "project_name" {
  type        = "string"
  description = "The name of the project to instanciate the instance at."
  default     = "developmet"
}

variable "region_name" {
  type        = "string"
  description = "The region that this terraform configuration will instanciate at."
  default     = "us-west1"
}

variable "zone_name" {
  type        = "string"
  description = "The zone that this terraform configuration will instanciate at."
  default     = "us-west1-b"
}

variable "machine_size" {
  type        = "string"
  description = "The size that this instance will be."
  default     = "f1-micro"
}

variable "image_name" {
  type        = "string"
  description = "The kind of VM this instance will become"
  default     = "ubuntu-os-cloud/ubuntu-1804-bionic-v20190403"
}

variable "script_path" {
  type        = "string"
  description = "Where is the path to the script locally on the machine?"
}

variable "private_key_path" {
  type        = "string"
  description = "The path to the private key used to connect to the instance"
}

variable "username" {
  type        = "string"
  description = "The name of the user that will be used to remote exec the script"
}
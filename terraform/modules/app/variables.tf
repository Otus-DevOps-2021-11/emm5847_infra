variable "public_key_path" {
  description = "Path to the public key used for ssh access"
  default     = "/home/home/.ssh/appuser.pub"
}
variable "private_key_path" {
  description = "Path to the private key used for ssh access"
  default     = "/home/home/.ssh/appuser"
}
variable "app_instance_count" {
  description = "Count of instance"
  default     = 1
}
variable app_disk_image {
  description = "Disk image for reddit app"
  default = "fd8uctatbblim7fetecj"
}
variable app_subnet_id {
  description = "Subnet id for reddit app"
  default = "enpm5ehu9lm25svnfmdi"
}
variable db_url {
  description = "Connectiong url"
  default = "127.0.0.1:27017"
}
variable enable_deploy_app {
  description = "Deploy app or not"
  default = "true"
}


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
variable "db_disk_image" {
  description = "Disk image for reddit db"
  default = "fd82a6h5hbhupbfjv0ej"
}
variable "db_subnet_id" {
  description = "Subnet id for reddit db"
  default = "enpm5ehu9lm25svnfmdi"
}
variable "enable_deploy_db" {
  description = "Deploy db server or not"
  default = "true"
}


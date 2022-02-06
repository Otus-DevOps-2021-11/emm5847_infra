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


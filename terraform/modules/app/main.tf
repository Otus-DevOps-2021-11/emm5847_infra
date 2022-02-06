resource "yandex_compute_instance" "app" {
  name  = "reddit-app"
#  count = var.app_instance_count
 # zone  = var.zone
  resources {
    core_fraction = 5
    cores         = 2
    memory        = 2
  }

  boot_disk {
    initialize_params {
      image_id = var.app_disk_image
    }
  }

  network_interface {
    subnet_id = var.app_subnet_id
    nat       = true
  }

  metadata = {
    ssh-keys = "ubuntu:${file(var.public_key_path)}"
  }

#  connection {
#    type        = "ssh"
#    host        = self.network_interface.0.nat_ip_address
#    user        = "ubuntu"
#    agent       = false
#    private_key = file(var.private_key_path)
#  }

#  provisioner "file" {
#    source      = "files/puma.service"
#    destination = "/tmp/puma.service"
#  }

#  provisioner "remote-exec" {
#    script = "files/deploy.sh"
#  }
}


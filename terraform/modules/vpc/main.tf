resource "yandex_compute_instance" "tes-vpc" {
  name  = "test-vpc"
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
}


terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
}

provider "yandex" {
  token = "AQAAAABb-fP9AATuwZ7v28HLNUTZoDPvOL3aCq4"
  cloud_id = "b1g35okphf23m1l8pb6k"
  folder_id = "b1gsn46bhh43i65o0lio"
  zone = "ru-central1-a"
}

resource "yandex_compute_instance" "app" {
  name        = "reddit-app"

  resources {
    cores  = 1
    memory = 2
  }

  boot_disk {
    initialize_params {
      image_id = "fd8h24coiv2imnl8q7rj"
    }
  }

  network_interface {
    subnet_id = "e9bgtqs5gjstf98pbeli"
    nat = true 
  }

  metadata = {
    foo      = "bar"
    ssh-keys = "ubuntu:${file("~/.ssh/appuser.pub")}"
  }
}


resource "yandex_compute_instance" "db" {
  name  = "reddit-db"
 # count = var.app_instance_count
 # zone  = var.zone
  resources {
    core_fraction = 5
    cores         = 2
    memory        = 2
  }

  boot_disk {
    initialize_params {
      image_id = var.db_disk_image
    }
  }

  network_interface {
    subnet_id = var.db_subnet_id
    nat       = true
  }

  metadata = {
    ssh-keys = "ubuntu:${file(var.public_key_path)}"
  }
}

resource "null_resource" "provisioners" {
  count = var.enable_deploy_db ? 1 : 0
  triggers = {
    yandex_instance_ids = join(",", yandex_compute_instance.db.*.id)
  }
  connection {
    type        = "ssh"
    host        = element(yandex_compute_instance.db.*.network_interface.0.nat_ip_address, 0)
    user        = "ubuntu"
    agent       = false
    private_key = file(var.private_key_path)
  }

  provisioner "remote-exec" {
    script = "../modules/db/mongodb.sh"
  }
}


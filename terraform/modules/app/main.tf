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
}

resource "null_resource" "provisioners" {
  count = var.enable_deploy_app ? 1 : 0

  triggers = {
    yandex_instance_ids = join(",", yandex_compute_instance.app.*.id)
  }
  connection {
    type        = "ssh"
    host        = element(yandex_compute_instance.app.*.network_interface.0.nat_ip_address, 0)
    user        = "ubuntu"
    agent       = false
    private_key = file(var.private_key_path)
  }

  provisioner "file" {
    source      = "../modules/app/puma.service"
    destination = "/tmp/puma.service"
  }

  provisioner "file" {
    source      = "../modules/app/deploy.sh"
    destination = "/tmp/deploy.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod u+x /tmp/deploy.sh",
      "/tmp/deploy.sh $HOME ${var.db_url}",
    ]
  }
}


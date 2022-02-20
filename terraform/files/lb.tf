resource "yandex_lb_network_load_balancer" "app-balancer" {
  name      = "reddit-load-balancer"
  region_id = "ru-central1"

  listener {
    port = var.app_port
    name = "reddit-lst"

    external_address_spec {
    }

  }

  attached_target_group {
    target_group_id = "${yandex_lb_target_group.app-target-group.id}"

    healthcheck {
      name                = "reddit-app-healthcheck"
      timeout             = "1"
      interval            = "2"
      healthy_threshold   = "2"
      unhealthy_threshold = "2"

      http_options {
        port = var.app_port
        path = "/"
      }
    }
  }
}

resource "yandex_lb_target_group" "app-target-group" {
  name = "reddit-target-group"

  region_id = "ru-central1"

  dynamic "target" {
    for_each = { for instance_app in yandex_compute_instance.app : instance_app.network_interface.0.ip_address => instance_app }
    content {
      subnet_id  = var.subnet_id
      address = target.key
    }
  }
}


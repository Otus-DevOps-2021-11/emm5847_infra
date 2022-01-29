resource "yandex_alb_load_balancer" "app-balancer" {
  name = "reddit-load-balancer"

  network_id = "enpm5ehu9lm25svnfmdi"

  allocation_policy {
    location {
      zone_id   = var.zone
      subnet_id = var.subnet_id
    }
  }

  listener {
    name = "reddit-lst"
    endpoint {
      address {
        external_ipv4_address {
        }
      }
      ports = [var.app_port]
    }
    http {
      handler {
        http_router_id = yandex_alb_http_router.app-http-router.id
      }
    }
  }
}

resource "yandex_alb_http_router" "app-http-router" {
  name      = "reddit-router"
  folder_id = var.folder_id
  labels = {
    tf-label    = "reddit-label"
    empty-label = ""
  }
}

resource "yandex_alb_virtual_host" "app-virtual-host" {
  name           = "reddit-virtual-host"
  http_router_id = yandex_alb_http_router.app-http-router.id
  route {
    name = "reddit-my-route"
    http_route {
      http_route_action {
        backend_group_id = yandex_alb_backend_group.app-backend-group.id
        timeout          = "3s"
      }
    }
  }
}

resource "yandex_alb_target_group" "app-target-group" {
  name = "reddit-target-group"

  target {
    subnet_id  = var.subnet_id
    ip_address = yandex_compute_instance.app.network_interface.0.ip_address
  }

  target {
    subnet_id  = var.subnet_id
    ip_address = yandex_compute_instance.app2.network_interface.0.ip_address
  }
}

resource "yandex_alb_backend_group" "app-backend-group" {
  name = "reddit-backend-group"

  http_backend {
    name             = "reddit-http-backend"
    weight           = 1
    port             = var.app_port
    target_group_ids = ["${yandex_alb_target_group.app-target-group.id}"]

    load_balancing_config {
      panic_threshold = 0
    }

  healthcheck {
    timeout = "1s"
    interval = "1s"
    healthy_threshold = "2"
    unhealthy_threshold = "1"
    healthcheck_port = var.app_port

    http_healthcheck {
      path  = "/"
    }
  }

    http2 = "false"
  }
}


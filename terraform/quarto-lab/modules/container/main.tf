terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 4.5"
    }
  }
}
resource "docker_image" "this" {
  name         = var.image_name
  keep_locally = true
}

resource "docker_container" "this" {
  name  = var.container_name
  image = docker_image.this.image_id

  networks_advanced {
    name = var.network_name
  }

  restart = var.restart_policy

  dynamic "healthcheck" {
    for_each = length(var.healthcheck_test) > 0 ? [1] : []

    content {
      test     = var.healthcheck_test
      interval = var.healthcheck_interval
      timeout  = var.healthcheck_timeout
      retries  = var.healthcheck_retries
    }
  }

  dynamic "ports" {
    for_each = var.external_port != null && var.internal_port != null ? [1] : []

    content {
      internal = var.internal_port
      external = var.external_port
    }
  }

  dynamic "volumes" {
    for_each = var.volume_name != null && var.volume_path != null ? [1] : []

    content {
      volume_name    = var.volume_name
      container_path = var.volume_path
    }
  }
}

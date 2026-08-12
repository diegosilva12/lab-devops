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

  restart = "unless-stopped"

  ports {
    internal = 80
    external = var.external_port
  }
}

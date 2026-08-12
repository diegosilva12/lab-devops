terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 4.5"
    }
  }
}

provider "docker" {
  host = var.docker_host
}

resource "docker_network" "lab" {
  name = "terraform-network"
}

module "nginx" {
  source = "./modules/nginx"

  container_name = "terraform-nginx"
  image_name     = "nginx:alpine"
  network_name   = docker_network.lab.name
  external_port  = var.nginx_external_port
}

resource "docker_volume" "redis_data" {
  name = "terraform-redis-data"

  lifecycle {
    prevent_destroy = true
  }
}

resource "docker_image" "redis" {
  name         = "redis:alpine"
  keep_locally = true
}

resource "docker_container" "redis" {
  name  = "terraform-redis"
  image = docker_image.redis.image_id

  restart = "unless-stopped"

  networks_advanced {
    name = docker_network.lab.name
  }
  volumes {
    volume_name    = docker_volume.redis_data.name
    container_path = "/data"
  }
}

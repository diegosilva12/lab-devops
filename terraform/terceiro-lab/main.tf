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

resource "docker_image" "nginx" {
  name         = "nginx:alpine"
  keep_locally = true
}

resource "docker_container" "nginx" {
  name  = "terraform-nginx"
  image = docker_image.nginx.image_id

  networks_advanced {
    name = docker_network.lab.name
  }

  restart = "unless-stopped"

  ports {
    internal = 80
    external = var.nginx_external_port
  }
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

terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 4.5"
    }
  }
}

provider "docker" {
  host = "ssh://diego@192.168.56.20:22"
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
    external = 8081
  }
}

resource "docker_volume" "redis_data" {
  name = "terraform-redis-data"
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

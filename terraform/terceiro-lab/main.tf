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
locals {
  nginx_environments = {
    principal = {
      container_name = "terraform-nginx"
      external_port  = var.nginx_external_port
    }

    homologacao = {
      container_name = "terraform-nginx-homologacao"
      external_port  = 8082
    }
    desenvolvimento = {
      container_name = "terraform-nginx-desenvolvimento"
      external_port  = 8083
    }
  }
}
resource "docker_network" "lab" {
  name = "terraform-network"
}

module "nginx" {
  source   = "./modules/container"
  for_each = local.nginx_environments

  container_name = each.value.container_name
  image_name     = "nginx:alpine"
  network_name   = docker_network.lab.name
  internal_port  = 80
  external_port  = each.value.external_port
}

resource "docker_volume" "redis_data" {
  name = "terraform-redis-data"

  lifecycle {
    prevent_destroy = true
  }
}

module "redis" {
  source = "./modules/container"

  container_name = "terraform-redis"
  image_name     = "redis:alpine"
  network_name   = docker_network.lab.name
  volume_name    = docker_volume.redis_data.name
  volume_path    = "/data"
}

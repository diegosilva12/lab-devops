terraform {
  backend "s3" {
    bucket = "terraform-state"
    key    = "quarto-lab/producao/terraform.tfstate"
    region = "us-east-1"

    endpoints = {
      s3 = "http://192.168.56.20:9000"
    }

    use_path_style              = true
    use_lockfile                = true
    skip_credentials_validation = true
    skip_requesting_account_id  = true
    skip_metadata_api_check     = true
    skip_region_validation      = true
    skip_s3_checksum            = true
  }

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

resource "docker_network" "this" {
  name = "quarto-lab-producao"
}

module "app" {
  source = "../../modules/container"

  container_name = "app-producao"
  image_name     = "nginx:alpine"
  network_name   = docker_network.this.name
  internal_port  = 80
  external_port  = 8092

  healthcheck_test = [
    "CMD",
    "wget",
    "--quiet",
    "--tries=1",
    "--spider",
    "http://localhost/",
  ]
}

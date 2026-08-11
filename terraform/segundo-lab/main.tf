terraform {
  required_providers {
    local = {
      source  = "hashicorp/local"
      version = "~> 2.5"
    }
  }
}

provider "local" {
}

resource "local_file" "servidores" {
  for_each = var.servidores

  filename        = "${path.module}/servidor-${each.value.ambiente}-${each.key}.txt"
  file_permission = "0644"

  content = <<-EOT
  Nome: ${each.key}
  IP: ${each.value.ip}
  Funcao: ${each.value.funcao}
  Ambiente: ${each.value.ambiente}
  EOT
}

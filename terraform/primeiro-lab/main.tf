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

resource "local_file" "anotacao_lab" {
  filename = "${path.module}/arquivo-criado-pelo-terraform.txt"

  content = <<-EOT
  Primeiro laboratório com Terraform.
  Arquivo criado automaticamente.
  Servidor: ${var.server_name}
  Status: gerenciado pelo Terraform.
  EOT
}

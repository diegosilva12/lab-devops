output "arquivo_criado" {
  description = "Caminho do arquivo gerenciado pelo Terraform"
  value       = local_file.anotacao_lab.filename
}

output "servidor_configurado" {
  description = "Servidor definido pela variável"
  value       = var.server_name
}

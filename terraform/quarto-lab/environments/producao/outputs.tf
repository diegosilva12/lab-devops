output "environment" {
  description = "Ambiente gerenciado por esta configuração"
  value       = "producao"
}

output "container_name" {
  description = "Nome do container de homologação"
  value       = module.app.container_name
}

output "application_url" {
  description = "URL da aplicação de homologação"
  value       = "http://192.168.56.20:8092"
}

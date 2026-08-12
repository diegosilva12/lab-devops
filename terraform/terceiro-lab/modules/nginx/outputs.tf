output "container_name" {
  description = "Nome do container criado"
  value       = docker_container.this.name
}

output "container_id" {
  description = "Identificador do container criado"
  value       = docker_container.this.id
}

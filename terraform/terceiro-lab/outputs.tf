output "nginx_external_port" {
  description = "Porta utilizada para acessar o Nginx"
  value       = var.nginx_external_port
}

output "docker_network_name" {
  description = "Nome da rede Docker criada pelo Terraform"
  value       = docker_network.lab.name
}

output "redis_volume_name" {
  description = "Nome do volume persistente do Redis"
  value       = docker_volume.redis_data.name
}

output "managed_containers" {
  description = "Containers administrados pelo Terraform"
  value = [
    module.nginx.container_name,
    module.nginx_homologacao.container_name,
    module.redis.container_name
  ]
}
output "nginx_urls" {
  description = "Endereços dos ambientes Nginx"
  value = {
    principal   = "http://192.168.56.20:${var.nginx_external_port}"
    homologacao = "http://192.168.56.20:8082"
  }
}

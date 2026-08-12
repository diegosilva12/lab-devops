output "nginx_principal_port" {
  description = "Porta do ambiente Nginx principal"
  value       = var.nginx_environments["principal"].external_port
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
  value = concat(
    [for environment in module.nginx : environment.container_name],
    [module.redis.container_name]
  )
}
output "nginx_urls" {
  description = "Endereços dos ambientes Nginx"
  value = {
    for name, environment in var.nginx_environments :
    name => "http://192.168.56.20:${environment.external_port}"
  }
}

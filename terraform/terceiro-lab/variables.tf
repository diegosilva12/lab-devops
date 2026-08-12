variable "docker_host" {
  description = "Endereço SSH do servidor que executa o Docker"
  type        = string
}

variable "nginx_external_port" {
  description = "Porta externa utilizada para acessar o Nginx"
  type        = number

  validation {
    condition     = var.nginx_external_port >= 1024 && var.nginx_external_port <= 65535
    error_message = "A porta do Nginx deve estar entre 1024 e 65535."
  }
}

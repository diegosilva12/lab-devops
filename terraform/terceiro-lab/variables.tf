variable "docker_host" {
  description = "Endereço SSH do servidor que executa o Docker"
  type        = string
}

variable "nginx_environments" {
  description = "Configurações dos ambientes Nginx"

  type = map(object({
    container_name = string
    external_port  = number
  }))

  validation {
    condition = alltrue([
      for environment in values(var.nginx_environments) :
      environment.external_port >= 1024 &&
      environment.external_port <= 65535
    ])

    error_message = "Todas as portas devem estar entre 1024 e 65535."
  }

  validation {
    condition = length(distinct([
      for environment in values(var.nginx_environments) :
      environment.external_port
    ])) == length(var.nginx_environments)

    error_message = "Cada ambiente Nginx deve utilizar uma porta externa diferente."
  }
}

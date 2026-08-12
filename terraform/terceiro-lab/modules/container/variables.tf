variable "container_name" {
  description = "Nome do container Docker"
  type        = string
}

variable "image_name" {
  description = "Imagem utilizada pelo container"
  type        = string
}

variable "network_name" {
  description = "Rede Docker conectada ao container"
  type        = string
}

variable "internal_port" {
  description = "Porta interna do container"
  type        = number
  default     = null
}

variable "external_port" {
  description = "Porta publicada no servidor"
  type        = number
  default     = null
}

variable "volume_name" {
  description = "Nome do volume conectado ao container"
  type        = string
  default     = null
}

variable "volume_path" {
  description = "Caminho de montagem dentro do container"
  type        = string
  default     = null
}

variable "restart_policy" {
  description = "Política de reinicialização do container"
  type        = string
  default     = "unless-stopped"
}
variable "healthcheck_test" {
  description = "Comando usado para verificar a saúde do container"
  type        = list(string)
  default     = []
}

variable "healthcheck_interval" {
  description = "Intervalo entre as verificações"
  type        = string
  default     = "30s"
}

variable "healthcheck_timeout" {
  description = "Tempo máximo de cada verificação"
  type        = string
  default     = "5s"
}

variable "healthcheck_retries" {
  description = "Quantidade de falhas antes de marcar como unhealthy"
  type        = number
  default     = 3
}

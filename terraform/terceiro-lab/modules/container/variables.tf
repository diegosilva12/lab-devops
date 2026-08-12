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

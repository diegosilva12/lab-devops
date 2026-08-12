variable "container_name" {
  description = "Nome do container Nginx"
  type        = string
}

variable "image_name" {
  description = "Imagem utilizada pelo container"
  type        = string
  default     = "nginx:alpine"
}

variable "network_name" {
  description = "Rede Docker conectada ao container"
  type        = string
}

variable "external_port" {
  description = "Porta externa do Nginx"
  type        = number
}

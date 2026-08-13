variable "docker_host" {
  description = "Endereço SSH do servidor que executa o Docker"
  type        = string

  validation {
    condition     = startswith(var.docker_host, "ssh://")
    error_message = "docker_host deve começar com ssh://."
  }
}

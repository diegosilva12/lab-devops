variable "servidores" {
  description = "Servidores que serão gerenciados"
  type = map(object({
    ip       = string
    funcao   = string
    ambiente = string
  }))

  default = {
    app = {
      ip       = "192.168.56.20"
      funcao   = "Aplicacao e Nginx"
      ambiente = "laboratorio"
    }

    control = {
      ip       = "192.168.56.10"
      funcao   = "Ansible e Terraform"
      ambiente = "laboratorio"
    }

    db = {
      ip       = "192.168.56.30"
      funcao   = "Banco de dados MySQL"
      ambiente = "laboratorio"
    }

  }
}

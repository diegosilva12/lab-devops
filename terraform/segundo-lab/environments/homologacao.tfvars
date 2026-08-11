servidores = {
  app = {
    ip       = "192.168.56.20"
    funcao   = "Aplicacao e Nginx"
    ambiente = "homologacao"
  }

  control = {
    ip       = "192.168.56.10"
    funcao   = "Ansible e Terraform"
    ambiente = "homologacao"
  }

  db = {
    ip       = "192.168.56.30"
    funcao   = "Banco de dados MySQL"
    ambiente = "homologacao"
  }
}

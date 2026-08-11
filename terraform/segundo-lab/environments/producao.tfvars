servidores = {
  app = {
    ip       = "10.0.1.20"
    funcao   = "Aplicacao e Nginx"
    ambiente = "producao"
  }

  control = {
    ip       = "10.0.1.10"
    funcao   = "Ansible e Terraform"
    ambiente = "producao"
  }

  db = {
    ip       = "10.0.2.30"
    funcao   = "Banco de dados MySQL"
    ambiente = "producao"
  }
}

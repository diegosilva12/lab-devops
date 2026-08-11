output "resumo_servidores" {
  description = "Resumo dos servidores gerenciados"

  value = {
    for nome, servidor in var.servidores : nome => {
      ip       = servidor.ip
      funcao   = servidor.funcao
      ambiente = servidor.ambiente
    }
  }
}

output "quantidade_servidores" {
  description = "Quantidade de servidores gerenciados"
  value       = length(var.servidores)
}

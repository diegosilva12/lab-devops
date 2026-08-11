variable "servidores" {
  description = "Servidores que serão gerenciados"
  type = map(object({
    ip       = string
    funcao   = string
    ambiente = string
  }))
}

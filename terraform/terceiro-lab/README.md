Laboratório Terraform com Docker

Laboratório criado para estudar Terraform por meio do gerenciamento remoto de uma infraestrutura Docker.

O Terraform é executado no servidor srv-control e se conecta via SSH ao Docker instalado no srv-app.

Arquitetura
srv-control
└── Terraform
    └── conexão SSH
        └── srv-app
            ├── terraform-network
            ├── Nginx principal — porta 8081
            ├── Nginx homologação — porta 8082
            ├── Nginx desenvolvimento — porta 8083
            ├── Redis
            └── volume terraform-redis-data
Recursos administrados
Rede Docker compartilhada.
Três ambientes Nginx.
Container Redis.
Volume persistente para os dados do Redis.
Healthchecks para Nginx e Redis.
Estrutura do projeto
terceiro-lab/
├── main.tf
├── variables.tf
├── outputs.tf
├── moves.tf
├── terraform.tfvars.example
└── modules/
    └── container/
        ├── main.tf
        ├── variables.tf
        └── outputs.tf
Principais conceitos praticados
Provider Docker com conexão remota via SSH.
Infraestrutura como código.
Variáveis simples e complexas com map(object).
Validação de portas.
Outputs.
Módulos reutilizáveis.
for_each.
Blocos dinâmicos.
Rede Docker.
Volume persistente.
Healthchecks.
Proteção de recursos com prevent_destroy.
Detecção de drift.
Movimentação de recursos com blocos moved.
Planos salvos antes da aplicação.
Versionamento com Git.
Configuração

Copie o arquivo de exemplo:

cp terraform.tfvars.example terraform.tfvars

Edite os valores locais:

nano terraform.tfvars

Exemplo:

docker_host = "ssh://usuario@IP_DO_SERVIDOR:22"

nginx_environments = {
  principal = {
    container_name = "terraform-nginx"
    external_port  = 8081
  }

  homologacao = {
    container_name = "terraform-nginx-homologacao"
    external_port  = 8082
  }

  desenvolvimento = {
    container_name = "terraform-nginx-desenvolvimento"
    external_port  = 8083
  }
}

O arquivo terraform.tfvars não é versionado porque pode conter informações específicas ou sensíveis do ambiente.

Execução

Inicialize o projeto:

terraform init

Formate os arquivos:

terraform fmt -recursive

Valide a configuração:

terraform validate

Revise as mudanças:

terraform plan

Aplique a infraestrutura:

terraform apply

Consulte os outputs:

terraform output
terraform output nginx_urls
Validação dos ambientes
curl -I http://IP_DO_SERVIDOR:8081
curl -I http://IP_DO_SERVIDOR:8082
curl -I http://IP_DO_SERVIDOR:8083

O resultado esperado é:

HTTP/1.1 200 OK
Verificação dos healthchecks
docker inspect \
  --format "{{.Name}}: {{.State.Health.Status}}" \
  terraform-nginx \
  terraform-nginx-homologacao \
  terraform-nginx-desenvolvimento \
  terraform-redis

O resultado esperado para cada container é healthy.

Persistência do Redis

O Redis utiliza o volume:

terraform-redis-data

Esse volume possui a proteção:

lifecycle {
  prevent_destroy = true
}

Essa configuração ajuda a evitar que o volume seja destruído acidentalmente pelo Terraform.

Fluxo utilizado
Código Terraform
      ↓
terraform fmt
      ↓
terraform validate
      ↓
terraform plan
      ↓
revisão das ações
      ↓
terraform apply
      ↓
validação da infraestrutura
      ↓
commit no Git
Observação

Este projeto foi criado para fins de estudo. Em um ambiente corporativo, o state deve ser armazenado em um backend remoto com controle de acesso, versionamento e bloqueio.

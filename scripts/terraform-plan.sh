#!/usr/bin/env bash

set -euo pipefail

ENVIRONMENT="${1:-}"
LAB_DIR="terraform/quarto-lab"
ENV_DIR="$LAB_DIR/environments/$ENVIRONMENT"

if [[ "$ENVIRONMENT" != "homologacao" && "$ENVIRONMENT" != "producao" ]]; then
  echo "Uso: $0 <homologacao|producao>"
  exit 1
fi

if [[ -z "${AWS_ACCESS_KEY_ID:-}" || -z "${AWS_SECRET_ACCESS_KEY:-}" ]]; then
  echo "Erro: credenciais do backend S3 não foram configuradas."
  exit 1
fi

if [[ ! -f "$ENV_DIR/terraform.tfvars" && -z "${TF_VAR_docker_host:-}" ]]; then
  echo "Erro: configure terraform.tfvars ou TF_VAR_docker_host."
  exit 1
fi

echo "==> Inicializando backend de $ENVIRONMENT"
terraform -chdir="$ENV_DIR" init -input=false

echo "==> Gerando plano de $ENVIRONMENT"

set +e
terraform -chdir="$ENV_DIR" plan \
  -input=false \
  -detailed-exitcode

PLAN_EXIT_CODE=$?
set -e

case "$PLAN_EXIT_CODE" in
  0)
    echo "==> $ENVIRONMENT: nenhuma alteração encontrada"
    ;;
  2)
    echo "==> $ENVIRONMENT: alterações encontradas para revisão"
    ;;
  *)
    echo "==> $ENVIRONMENT: falha ao gerar o plano"
    exit "$PLAN_EXIT_CODE"
    ;;
esac

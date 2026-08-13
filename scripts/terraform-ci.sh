#!/usr/bin/env bash

set -euo pipefail

LAB_DIR="terraform/quarto-lab"
CI_DATA_DIR="$(mktemp -d)"

cleanup() {
  rm -rf "$CI_DATA_DIR"
}

trap cleanup EXIT

echo "==> Verificando formatação"
terraform fmt -check -recursive "$LAB_DIR"

for environment in homologacao producao; do
  ENV_DIR="$LAB_DIR/environments/$environment"

  export TF_DATA_DIR="$CI_DATA_DIR/$environment"

  echo
  echo "==> Inicializando $environment sem acessar o backend"
  terraform -chdir="$ENV_DIR" init -backend=false -input=false

  echo "==> Validando $environment"
  terraform -chdir="$ENV_DIR" validate
done

unset TF_DATA_DIR

echo
echo "==> CI concluída com sucesso"

.PHONY: help fmt ci check

LAB_DIR := terraform/quarto-lab

help:
	@echo "Comandos disponíveis:"
	@echo "  make fmt    Formata os arquivos Terraform"
	@echo "  make ci     Executa as validações da pipeline"
	@echo "  make check  Formata e depois valida localmente"

fmt:
	terraform fmt -recursive $(LAB_DIR)

ci:
	./scripts/terraform-ci.sh

check: fmt ci

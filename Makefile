.PHONY: help fmt ci check plan plan-homologacao plan-producao

LAB_DIR := terraform/quarto-lab

help:
	@echo "Comandos disponíveis:"
	@echo "  make fmt                Formata os arquivos Terraform"
	@echo "  make ci                 Executa as validações da pipeline"
	@echo "  make check              Formata e depois valida localmente"
	@echo "  make plan               Gera planos dos dois ambientes"
	@echo "  make plan-homologacao   Gera o plano de homologação"
	@echo "  make plan-producao      Gera o plano de produção"

fmt:
	terraform fmt -recursive $(LAB_DIR)

ci:
	./scripts/terraform-ci.sh

check: fmt ci

plan: plan-homologacao plan-producao

plan-homologacao:
	./scripts/terraform-plan.sh homologacao

plan-producao:
	./scripts/terraform-plan.sh producao

include .env

terraform-init:
	terraform -chdir=terraform init

terraform-apply:
	TF_VAR_AWS_REGION=$(AWS_REGION) \
	TF_VAR_AWS_PROFILE=$(AWS_PROFILE) \
	TF_VAR_ORGANISATION_NAME=$(ORGANISATION_NAME) \
    TF_VAR_REPOSITORY_NAME=$(REPOSITORY_NAME) \
    terraform -chdir=terraform apply

terraform-destroy:
	TF_VAR_AWS_REGION=$(AWS_REGION) \
	TF_VAR_AWS_PROFILE=$(AWS_PROFILE) \
	TF_VAR_ORGANISATION_NAME=$(ORGANISATION_NAME) \
	TF_VAR_REPOSITORY_NAME=$(REPOSITORY_NAME) \
	terraform -chdir=terraform destroy

terraform-show:
	terraform -chdir=terraform show

terraform-output:
	terraform -chdir=terraform output

BIN_DIR?=~/bin

# Environment name
ENV?=stage

PACKER?=${BIN_DIR}/packer
PACKER_VAR_FILE?=packer/variables-gitlab-runner.json

ANSIBLE?=../../.venv/bin/ansible
TERRAFORM?=${BIN_DIR}/terraform
TFLINT?=${BIN_DIR}/tflint


packer_build:
	${PACKER} build -var-file=packer/variables.json -var-file=${PACKER_VAR_FILE} packer/docker.json

packer_validate:
	${PACKER} --version
	${PACKER} validate -var-file=packer/variables.json -var-file=${PACKER_VAR_FILE} packer/docker.json


terraform_init:
	cd ./terraform && ${TERRAFORM} init
	cd ./terraform/${ENV} && ${TERRAFORM} init

terraform_init_nobackend:
	cd ./terraform/${ENV} && ${TERRAFORM} init -backend=false

terraform_validate:
	${TERRAFORM} --version
	cd ./terraform && ${TERRAFORM} validate
	cd ./terraform/stage && ${TERRAFORM} validate

terraform_tflint:
	cd ./terraform && ${TFLINT}
	cd ./terraform/stage && ${TFLINT}

terraform_apply:
	cd ./terraform/${ENV} && ${TERRAFORM} apply

terraform_destroy:
	cd ./terraform/${ENV} && ${TERRAFORM} destroy


ansible_install_requirements:
	cd ./ansible && ${ANSIBLE}-galaxy install -r environments/stage/requirements.yml

ansible_inventory_list:
	cd ./ansible && ${ANSIBLE}-inventory --list

ansible_lint:
	cd ./ansible && find playbooks -name "*.yml" -type f -print0 | xargs -0 -n1 ${ANSIBLE}-lint

ansible_syntax:
	cd ./ansible && find playbooks -name "*.yml" -type f -print0 | xargs -0 -n1 ${ANSIBLE}-playbook -i environments/stage/inventory.gcp.yml --syntax-check


push_gitlab:
	git push gitlab gitlab-ci-1

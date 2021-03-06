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

packer_build_gitlab:
	make packer_validate PACKER_VAR_FILE=packer/variables-gitlab.json
	make packer_build PACKER_VAR_FILE=packer/variables-gitlab.json

packer_build_gitlab_runner:
	make packer_validate PACKER_VAR_FILE=packer/variables-gitlab-runner.json
	make packer_build PACKER_VAR_FILE=packer/variables-gitlab-runner.json

packer_build_dev_server:
	make packer_validate PACKER_VAR_FILE=packer/variables-stage-server.json
	make packer_build PACKER_VAR_FILE=packer/variables-stage-server.json

packer_all: packer_build_gitlab packer_build_gitlab_runner packer_build_dev_server


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

terraform_all: terraform_init terraform_validate terraform_tflint terraform_apply


ansible_install_requirements:
	cd ./ansible && ${ANSIBLE}-galaxy install -r environments/stage/requirements.yml

ansible_inventory_list:
	cd ./ansible && ${ANSIBLE}-inventory --list

ansible_lint:
	cd ./ansible && find playbooks -name "*.yml" -type f -print0 | xargs -0 -n1 ${ANSIBLE}-lint

ansible_syntax:
	cd ./ansible && find playbooks -name "*.yml" -type f -print0 | xargs -0 -n1 ${ANSIBLE}-playbook -i environments/stage/inventory.gcp.yml --syntax-check

ansible_provision_runner:
	cd ./ansible && ${ANSIBLE}-playbook -i environments/stage/inventory.gcp.yml playbooks/gitlab-runner.yml

ansible_all: ansible_install_requirements ansible_inventory_list ansible_lint ansible_syntax ansible_provision_runner

push_gitlab:
	git push gitlab gitlab-ci-1

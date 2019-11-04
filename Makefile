BIN_DIR?=~/bin
TEMP_DIR?=/tmp

# Docker-machine
DOCKER_MACHINE_VERSION?=v0.16.0
DOCKER_MACHINE_BASEURL=https://github.com/docker/machine/releases/download
DOCKER_MACHINE_OS?=$(shell uname -s)
DOCKER_MACHINE_ARCH?=$(shell uname -m)
DOCKER_MACHINE?=${BIN_DIR}/docker-machine
DOCKER_MACHINE_NAME?=docker-host
DOCKER_MACHINE_TYPE?=n1-standard-1
DOCKER_MACHINE_REGION?=europe-west1-b

# Packer-related variables
PACKER_VERSION?=1.4.4
PACKER_URL=https://releases.hashicorp.com/packer/${PACKER_VERSION}/packer_${PACKER_VERSION}_linux_amd64.zip
PACKER?=${BIN_DIR}/packer

# Ansible-related variables
## Relative to ./ansible subdir
ANSIBLE?=../../.venv/bin/ansible

debug:
	echo BIN_DIR=${BIN_DIR}
	echo TEMP_DIR=${TEMP_DIR}
	echo DOCKER_MACHINE_VERSION=${DOCKER_MACHINE_VERSION}
	echo DOCKER_MACHINE_BASEURL=${DOCKER_MACHINE_BASEURL}
	echo DOCKER_MACHINE_OS=${DOCKER_MACHINE_OS}
	echo DOCKER_MACHINE_ARCH=${DOCKER_MACHINE_ARCH}
	echo DOCKER_MACHINE=${DOCKER_MACHINE}
	echo DOCKER_MACHINE_NAME=${DOCKER_MACHINE_NAME}
	echo DOCKER_MACHINE_TYPE=${DOCKER_MACHINE_TYPE}
	echo DOCKER_MACHINE_REGION=${DOCKER_MACHINE_REGION}

install_requirements:
	test -d ./.venv || python3 -m venv ./.venv
	./.venv/bin/pip install -r requirements.txt

install_docker_machine:
	curl -L ${DOCKER_MACHINE_BASEURL}/${DOCKER_MACHINE_VERSION}/docker-machine-${DOCKER_MACHINE_OS}-${DOCKER_MACHINE_ARCH} >${TEMP_DIR}/docker-machine && \
	mv ${TEMP_DIR}/docker-machine ${BIN_DIR}/docker-machine && \
	chmod +x ${BIN_DIR}/docker-machine

install_packer:
	wget ${PACKER_URL} -O ${TEMP_DIR}/packer-${PACKER_VERSION}.zip
	unzip -o ${TEMP_DIR}/packer-${PACKER_VERSION}.zip -d ${TEMP_DIR}/
	mv ${TEMP_DIR}/packer ${BIN_DIR}/packer-${PACKER_VERSION}
	ln -sf packer-${PACKER_VERSION} ${BIN_DIR}/packer
	${BIN_DIR}/packer --version && rm ${TEMP_DIR}/packer-${PACKER_VERSION}.zip


docker_machine_create:
	${DOCKER_MACHINE} create --driver google \
		--google-machine-image https://www.googleapis.com/compute/v1/projects/ubuntu-os-cloud/global/images/family/ubuntu-1604-lts \
		--google-machine-type ${DOCKER_MACHINE_TYPE} \
		--google-zone ${DOCKER_MACHINE_REGION} \
		${DOCKER_MACHINE_NAME}
	${DOCKER_MACHINE} env ${DOCKER_MACHINE_NAME}

docker_machine_rm:
	${DOCKER_MACHINE} rm ${DOCKER_MACHINE_NAME}
	${DOCKER_MACHINE} env --unset


monolith_packer_build:
	${PACKER} build -var-file=docker-monolith/packer/variables.json docker-monolith/packer/docker.json

monolith_packer_validate:
	${PACKER} --version
	${PACKER} validate -var-file=docker-monolith/packer/variables.json docker-monolith/packer/docker.json


monolith_ansible_install_requirements:
	cd ./docker-monolith/ansible && ${ANSIBLE}-galaxy install -r inventory/requirements.yml

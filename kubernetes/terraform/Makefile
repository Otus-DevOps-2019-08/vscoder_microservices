BIN_DIR?=~/bin
TEMP_DIR?=/tmp
# Environment name
ENV?=stage

# Terraform-related variables
TERRAFORM_VERSION?=0.12.18
TERRAFORM_URL=https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip
TERRAFORM?=${BIN_DIR}/terraform

# Tflint-related variables
TFLINT_VERSION?=0.12.1
TFLINT_URL=https://github.com/wata727/tflint/releases/download/v${TFLINT_VERSION}/tflint_linux_amd64.zip
TFLINT?=${BIN_DIR}/tflint

# kubergrunt
KUBERGRUNT_VERSION?=v0.5.8
KUBERGRUNT_URL=https://github.com/gruntwork-io/kubergrunt/releases/download/${KUBERGRUNT_VERSION}/kubergrunt_linux_amd64
KUBERGRUNT?=${BIN_DIR}/kubergrunt

debug:
	echo BIN_DIR=${BIN_DIR}
	echo TEMP_DIR=${TEMP_DIR}
	echo ENV=${ENV}
	echo TERRAFORM_VERSION=${TERRAFORM_VERSION}
	echo TERRAFORM_URL=${TERRAFORM_URL}
	echo TERRAFORM=${TERRAFORM}
	echo TFLINT_VERSION=${TFLINT_VERSION}
	echo TFLINT_URL=${TFLINT_URL}
	echo TFLINT=${TFLINT}
	echo KUBERGRUNT_VERSION=${KUBERGRUNT_VERSION}
	echo KUBERGRUNT_URL=${KUBERGRUNT_URL}
	echo KUBERGRUNT=${KUBERGRUNT}


install_terraform:
	wget ${TERRAFORM_URL} -O ${TEMP_DIR}/terraform-${TERRAFORM_VERSION}.zip
	unzip -o ${TEMP_DIR}/terraform-${TERRAFORM_VERSION}.zip -d ${TEMP_DIR}/
	mv ${TEMP_DIR}/terraform ${BIN_DIR}/terraform-${TERRAFORM_VERSION}
	ln -sf terraform-${TERRAFORM_VERSION} ${BIN_DIR}/terraform
	${BIN_DIR}/terraform --version && rm ${TEMP_DIR}/terraform-${TERRAFORM_VERSION}.zip

install_tflint:
	wget ${TFLINT_URL} -O ${TEMP_DIR}/tflint-${TFLINT_VERSION}.zip
	unzip -o ${TEMP_DIR}/tflint-${TFLINT_VERSION}.zip -d ${TEMP_DIR}/
	mv ${TEMP_DIR}/tflint ${BIN_DIR}/tflint-${TFLINT_VERSION}
	ln -sf tflint-${TFLINT_VERSION} ${BIN_DIR}/tflint
	${BIN_DIR}/tflint --version && rm ${TEMP_DIR}/tflint-${TFLINT_VERSION}.zip

install_kubergrunt:
	wget ${KUBERGRUNT_URL} -O ${TEMP_DIR}/kubergrunt-${KUBERGRUNT_VERSION}
	mv ${TEMP_DIR}/kubergrunt-${KUBERGRUNT_VERSION} ${BIN_DIR}/kubergrunt-${KUBERGRUNT_VERSION}
	ln -sf kubergrunt-${KUBERGRUNT_VERSION} ${BIN_DIR}/kubergrunt
	chmod +x ${BIN_DIR}/kubergrunt
	${BIN_DIR}/kubergrunt --version

init:
	${TERRAFORM} init

init_nobackend:
	${TERRAFORM} init -backend=false
validate:
	${TERRAFORM} --version
	${TERRAFORM} validate
tflint:
	${BIN_DIR}/tflint
apply:
	${TERRAFORM} apply
destroy:
	${TERRAFORM} destroy
url:
	${TERRAFORM} output cluster_endpoint


install: install_terraform install_tflint

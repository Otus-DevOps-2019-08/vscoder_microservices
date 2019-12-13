#!/bin/sh
#
# Create fake variables
#
set -exu

cd ./docker

# Create fake variables files
cp docker-monolith/packer/variables.json.example docker-monolith/packer/variables.json
cp docker-monolith/terraform/terraform.tfvars.example docker-monolith/terraform/terraform.tfvars
cp docker-monolith/terraform/stage/terraform.tfvars.example docker-monolith/terraform/stage/terraform.tfvars
# Initialize terraform
make monolith_terraform_init_nobackend ENV=""
make monolith_terraform_init_nobackend ENV="stage"
# Create fake ansible vault key file
mkdir -p ~/.ansible/keys/
echo "fakepassword" > ~/.ansible/keys/otus-devops-vault.key

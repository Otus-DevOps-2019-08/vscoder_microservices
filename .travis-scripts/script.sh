#!/bin/sh
#
# Run tests
#
set -exu

cd ./docker

make monolith_packer_validate monolith_terraform_validate monolith_terraform_tflint
make monolith_ansible_syntax monolith_ansible_lint

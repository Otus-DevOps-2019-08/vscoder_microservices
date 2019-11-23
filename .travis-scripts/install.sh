#!/bin/sh
#
# Install necessary packages and binaries
#
set -exu

make install_packer install_terraform install_tflint
sudo apt-get update && sudo apt-get install python-virtualenv
make install_requirements_virtualenv
# Fix Failed to validate the SSL certificate for galaxy.ansible.com:443 #795 https://github.com/ansible/galaxy/issues/795
./.venv/bin/pip install -U "urllib3[secure]"
make monolith_ansible_install_requirements

#!/bin/bash
set -eux
ANSIBLE="${ANSIBLE:=./.venv/bin/ansible}"
if [ -x ${ANSIBLE}-playbook ]
then
    ANSIBLE_FORCE_COLOR=1 PYTHONUNBUFFERED=1 ${ANSIBLE}-playbook "$@"
else
    ANSIBLE_FORCE_COLOR=1 PYTHONUNBUFFERED=1 ansible-playbook "$@"
fi

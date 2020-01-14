#!/bin/bash
set -eux

echo docker build -t ${REGISTRY_USER_NAME}/${IMAGE}:v${HELM_VERSION} .
docker build -t ${REGISTRY_USER_NAME}/${IMAGE}:v${HELM_VERSION} .

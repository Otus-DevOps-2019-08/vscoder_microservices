#!/bin/bash
set -eux

echo docker build --build-arg HELM_VERSION=${HELM_VERSION} -t ${REGISTRY_USER_NAME}/${IMAGE}:v${HELM_VERSION} .
docker build --build-arg HELM_VERSION=${HELM_VERSION} -t ${REGISTRY_USER_NAME}/${IMAGE}:v${HELM_VERSION} .

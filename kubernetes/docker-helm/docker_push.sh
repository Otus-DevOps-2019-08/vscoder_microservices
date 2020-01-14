#!/bin/bash
set -eux

docker push ${REGISTRY_USER_NAME}/${IMAGE}:v${HELM_VERSION}

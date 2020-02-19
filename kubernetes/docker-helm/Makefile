HELM_VERSION=2.16.1

.PHONY: build publish

build:
	. ./env \
	&& export HELM_VERSION=$${HELM_VERSION} \
	&& ./docker_build.sh

publish:
	. ./env \
	&& export HELM_VERSION=$${HELM_VERSION} \
	&& ./docker_push.sh

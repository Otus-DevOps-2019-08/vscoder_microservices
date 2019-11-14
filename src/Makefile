DOCKERHUB_LOGIN?=vscoder

POST_VERSION?=1.0
COMMENT_VERSION?=1.0
UI_VERSION?=1.0

build_post:
	docker build -t ${DOCKERHUB_LOGIN}/post:${POST_VERSION} ./post-py

build_comment:
	docker build -t ${DOCKERHUB_LOGIN}/comment:${COMMENT_VERSION} ./comment

build_ui:
	docker build -t ${DOCKERHUB_LOGIN}/ui:${UI_VERSION} ./ui

build_all: build_post build_comment build_ui

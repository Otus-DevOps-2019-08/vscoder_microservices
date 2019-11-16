DOCKERHUB_LOGIN?=vscoder

POST_VERSION?=1.0
COMMENT_VERSION?=1.0
UI_VERSION?=2.0

REDDIT_NETWORK_NAME?=reddit

build_post:
	docker build -t ${DOCKERHUB_LOGIN}/post:${POST_VERSION} ./post-py

build_comment:
	docker build -t ${DOCKERHUB_LOGIN}/comment:${COMMENT_VERSION} ./comment

build_ui:
	docker build -t ${DOCKERHUB_LOGIN}/ui:${UI_VERSION} ./ui

build_all: build_post build_comment build_ui

run_all:
	docker network create ${REDDIT_NETWORK_NAME}
	docker run -d --network=${REDDIT_NETWORK_NAME} \
		--network-alias=post_db --network-alias=comment_db mongo:latest
	docker run -d --network=${REDDIT_NETWORK_NAME} \
		--network-alias=post ${DOCKERHUB_LOGIN}/post:${POST_VERSION}
	docker run -d --network=${REDDIT_NETWORK_NAME} \
		--network-alias=comment ${DOCKERHUB_LOGIN}/comment:${COMMENT_VERSION}
	docker run -d --network=${REDDIT_NETWORK_NAME} \
		-p 9292:9292 ${DOCKERHUB_LOGIN}/ui:${UI_VERSION}

kill_all:
	docker ps
	echo -n "\nWARNING: This command kill all running containers! You have 5 seconds to CTRL+C...\n" && sleep 5
	docker ps -q | xargs docker kill \
	; docker network rm ${REDDIT_NETWORK_NAME}

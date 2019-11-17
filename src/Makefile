DOCKERHUB_LOGIN?=vscoder

POST_VERSION?=2.0-alpine
COMMENT_VERSION?=2.0-alpine
UI_VERSION?=3.0-alpine

REDDIT_NETWORK_NAME?=reddit

build_post:
	docker build -t ${DOCKERHUB_LOGIN}/post:${POST_VERSION} ./post-py

dive_post:
	docker run --rm -it \
		-v /var/run/docker.sock:/var/run/docker.sock \
		-e CI=true \
		wagoodman/dive:latest $$(docker images -q ${DOCKERHUB_LOGIN}/post:${POST_VERSION})

build_comment:
	docker build -t ${DOCKERHUB_LOGIN}/comment:${COMMENT_VERSION} ./comment

dive_comment:
	docker run --rm -it \
		-v /var/run/docker.sock:/var/run/docker.sock \
		-e CI=true \
		wagoodman/dive:latest $$(docker images -q ${DOCKERHUB_LOGIN}/comment:${COMMENT_VERSION})

build_ui:
	docker build -t ${DOCKERHUB_LOGIN}/ui:${UI_VERSION} ./ui

dive_ui:
	docker run --rm -it \
		-v /var/run/docker.sock:/var/run/docker.sock \
		-e CI=true \
		wagoodman/dive:latest $$(docker images -q ${DOCKERHUB_LOGIN}/ui:${UI_VERSION})

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

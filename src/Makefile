DOCKERHUB_LOGIN?=vscoder

POST_VERSION?=2.0-alpine
COMMENT_VERSION?=2.0-alpine
UI_VERSION?=3.0-alpine

REDDIT_NETWORK_NAME?=reddit
REDDIT_DB_VOLUME_NAME?=reddit_db

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
	docker network inspect ${REDDIT_NETWORK_NAME}_back 1>/dev/null || docker network create ${REDDIT_NETWORK_NAME}_back
	docker network inspect ${REDDIT_NETWORK_NAME}_front 1>/dev/null || docker network create ${REDDIT_NETWORK_NAME}_front
	docker volume inspect ${REDDIT_DB_VOLUME_NAME} 1>/dev/null || docker volume create ${REDDIT_DB_VOLUME_NAME}
	docker run -d \
		--name mongo_db \
		--network=${REDDIT_NETWORK_NAME}_back \
		--network-alias=post_db \
		--network-alias=comment_db \
		-v reddit_db:/data/db \
		mongo:latest
	docker run -d \
		--name post \
		--network=${REDDIT_NETWORK_NAME}_back \
		--network-alias=post \
		${DOCKERHUB_LOGIN}/post:${POST_VERSION}
	docker network connect ${REDDIT_NETWORK_NAME}_front post
	docker run -d \
		--name comment \
		--network=${REDDIT_NETWORK_NAME}_back \
		--network-alias=comment \
		${DOCKERHUB_LOGIN}/comment:${COMMENT_VERSION}
	docker network connect ${REDDIT_NETWORK_NAME}_front comment
	docker run -d \
		--name ui \
		--network=${REDDIT_NETWORK_NAME}_front \
		-p 9292:9292 \
		${DOCKERHUB_LOGIN}/ui:${UI_VERSION}

kill_all:
	docker ps
	echo -n "\nWARNING: This command kill all running containers! You have 5 seconds to CTRL+C...\n" && sleep 5
	docker ps -q | xargs docker kill \
	; docker network rm ${REDDIT_NETWORK_NAME}

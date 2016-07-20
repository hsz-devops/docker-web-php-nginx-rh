# v1.6.1    2016-06-20     webmaster@highskillz.com

IMAGE_NAME=ez123/web-php-nginx-rh
TAG_NAME=rh-alpine

THIS_DIR := $(dir $(abspath $(lastword $(MAKEFILE_LIST))))
TIMESTAMP=$(shell date +"%Y%m%d_%H%M%S")

BUILD_OPTS=--pull --force-rm
#BUILD_OPTS=--force-rm

# --------------------------------------------------------------------------
default: build

# --------------------------------------------------------------------------
build: _DOCKER_BUILD_OPTS=$(BUILD_OPTS)
build: _build_image

rebuild: _DOCKER_BUILD_OPTS=--no-cache $(BUILD_OPTS)
rebuild: _build_image

_build_image: _check-env-base
	docker build \
		$(_DOCKER_BUILD_OPTS) \
			-t $(IMAGE_NAME):$(TAG_NAME) \
			-t $(IMAGE_NAME):latest      \
		.

# --------------------------------------------------------------------------
_check-env-base:
	test -n "$(TIMESTAMP)"
	test -n "$(TAG_NAME)"

# --------------------------------------------------------------------------
shell: _check-env-base
	docker run --rm -it $(IMAGE_NAME):$(TAG_NAME) bash

# --------------------------------------------------------------------------
rmi: _check-env-base
	docker rmi $(IMAGE_NAME):$(TAG_NAME)

# --------------------------------------------------------------------------
clean-junk:
	docker rm        `docker ps -aq -f status=exited`      || true
	docker rmi       `docker images -q -f dangling=true`   || true
	docker volume rm `docker volume ls -qf dangling=true`  || true

# --------------------------------------------------------------------------
list:
	@echo "# i ########################################"
	docker images | head -n 20
	docker images | wc -l
	@echo "# v ########################################"
	docker volume ls
	@echo "# n ########################################"
	docker network ls
	@echo "# p ########################################"
	docker ps
	@echo "# p-a ######################################"
	docker ps -a

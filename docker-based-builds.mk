# DEPENDENCIES
#		- PROJECT_NAME
#		- ORG_NAME
#		- BINARY_DEST_DIR
#		- LDFLAGS

DOCKER_DEV_BIN_DIR ?= bin
DOCKER_DEV_MAIN ?= main.go
DOCKER_DEV_BIN_NAME ?= $(PROJECT_NAME)
DOCKER_DEV_SRC_PACKAGES ?= "./..."

DOCKER_DEV_CGO_ENABLED ?= 0
DOCKER_DEV_IMAGE ?= quay.io/deis/go-dev:0.4.0
DOCKER_DEV_REPO_PATH := github.com/${ORG_NAME}/${PROJECT_NAME}
DOCKER_DEV_WORK_DIR := /go/src/${DOCKER_DEV_REPO_PATH}
DOCKER_DEV_PREFIX := docker run --rm -e GO15VENDOREXPERIMENT=1 -e CGO_ENABLED=${DOCKER_DEV_CGO_ENABLED} -v ${CURDIR}:${DOCKER_DEV_WORK_DIR} -w ${DOCKER_DEV_WORK_DIR}
DOCKER_DEV_CMD := ${DOCKER_DEV_PREFIX} ${DOCKER_DEV_IMAGE}

docker-go-bootstrap:
	${DOCKER_DEV_CMD} glide install

docker-go-build:
	${DOCKER_DEV_CMD} go build -a -installsuffix cgo -ldflags ${LDFLAGS} -o ${BINARY_DEST_DIR}/boot boot.go

docker-go-test:
	${DOCKER_DEV_CMD} go test $(glide nv)

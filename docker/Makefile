COMPOSE_RUN_NODE = docker-compose run --rm mock-service
COMPOSE_UP_NODE = docker-compose up -d mock-service
GO_PREFLIGHT_REPO = https://github.com/natemarks/preflight.git
GO_PREFLIGHT_VER = v0.0.9
GO_MOCK-SERVICE_REPO = https://github.com/natemarks/mock-service.git
GO_MOCK-SERVICE_VER = v0.0.3
ENVFILE ?= env.template


.PHONY: build run stop

build:
	mkdir -p ${HOME}/build/preflight
	git clone $(GO_PREFLIGHT_REPO) ${HOME}/build/preflight
	cd ${HOME}/build/preflight;git fetch --tags;git checkout tags/$(GO_PREFLIGHT_VER);GOOS=linux GOARCH=amd64 go build .
	rm -f mock_service/preflight
	cp ${HOME}/build/preflight/preflight mock_service/
	rm -rf ${HOME}/build/preflight

	mkdir -p ${HOME}/build/mock-service
	git clone $(GO_MOCK-SERVICE_REPO) ${HOME}/build/mock-service
	cd ${HOME}/build/mock-service;git fetch --tags;git checkout tags/$(GO_MOCK-SERVICE_VER);GOOS=linux GOARCH=amd64 go build .
	rm -f mock_service/mock-service
	cp ${HOME}/build/mock-service/mock-service mock_service/
	rm -rf ${HOME}/build/mock-service
	docker-compose build

run:
	$(COMPOSE_UP_NODE)

stop:
	docker-compose down

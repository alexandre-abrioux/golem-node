SHELL := /bin/bash
.DEFAULT_GOAL := help

include .env

.PHONY: help
help:		## This help message
	@echo -e "$$(grep -hE '^\S+:.*##' $(MAKEFILE_LIST) | sed -e 's/:.*##\s*/:/' -e 's/^\(.\+\):\(.*\)/\\x1b[36m\1\\x1b[m:\2/' | column -c2 -t -s :)"

.PHONY: build
build: 		## buid services
	docker-compose build

.PHONY: up
up: 		## deploy services
	docker-compose up -d --remove-orphans

.PHONY: stop
stop: 		## stop services
	docker-compose stop

.PHONY: destroy
destroy: 	## destroy services
	docker-compose down

.PHONY: restart
restart: 	## restart services
	docker-compose restart

.PHONY: shell
shell: 		## enter container shell
	docker-compose exec node bash

.PHONY: logs
logs: 		## display container logs
	docker-compose logs -t --tail=10 -f node

.PHONY: setup
setup: 		## setup node for the first time
	docker-compose run --rm node golemsp run


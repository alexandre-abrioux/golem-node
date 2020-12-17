SHELL := /bin/bash
.DEFAULT_GOAL := help

include .env

.PHONY: help
help:		## Display this help message
	@echo -e "$$(grep -hE '^\S+:.*##' $(MAKEFILE_LIST) | sed -e 's/:.*##\s*/:/' -e 's/^\(.\+\):\(.*\)/\\x1b[36m\1\\x1b[m:\2/' | column -c2 -t -s :)"

.PHONY: pull
pull: 		## Pull the latest image version
	docker-compose pull

.PHONY: up
up: 		## Start the node
	docker-compose up -d --remove-orphans

.PHONY: stop
stop: 		## Stop the node
	docker-compose stop

.PHONY: destroy
destroy: 	## Destroy the node (volumes are not removed)
	docker-compose down --remove-orphans

.PHONY: restart
restart: 	## Restart the node
	docker-compose restart

.PHONY: shell
shell: 		## Enter the container shell
	docker-compose exec node bash

.PHONY: logs
logs: 		## Display the container logs
	docker-compose logs -t --tail=10 -f node

.PHONY: setup
setup: 		## Setup the node for the first time
	docker-compose run --rm node golemsp run

.PHONY: status
status: 	## Get the running node status
	docker-compose exec node golemsp status

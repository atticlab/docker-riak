ARGS = $(filter-out $@,$(MAKECMDGOALS))
MAKEFLAGS += --silent
CONTAINERS = $(shell docker ps -a -q)
VOLUMES = $(shell docker volume ls |awk 'NR>1 {print $2}')
COMPOSER_DIR = $(realpath $(PWD))

list:
	sh -c "echo; $(MAKE) -p no_targets__ | awk -F':' '/^[a-zA-Z0-9][^\$$#\/\\t=]*:([^=]|$$)/ {split(\$$1,A,/ /);for(i in A)print A[i]}' | grep -v '__\$$' | grep -v 'Makefile'| sort"

#############################
# Docker machine states
#############################

start:
	docker-compose start

stop:
	docker-compose stop

state:
	docker-compose ps

build:
	@if [ ! -s ./.env ]; then \
		./scripts/setup.sh; \
    fi

	docker-compose build
	docker-compose up -d

add:
	docker exec crypto-riak-node riak-admin cluster join ${ARGS}

leave-cluster:
	docker exec crypto-riak-node riak-admin cluster leave

remove:
	docker exec crypto-riak-node riak-admin cluster leave ${ARGS}

attach:
	docker exec -i -t ${c} /bin/bash

purge:
	docker stop $(CONTAINERS)
	docker rm $(CONTAINERS)
	docker volume rm $(VOLUMES)
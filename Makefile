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

# Build node
build:
	@if [ ! -s ./.env ]; then \
		./scripts/setup.sh; \
    fi

	docker-compose build
	docker-compose up -d

# Adds node to cluster
join:
	docker exec crypto-riak-node riak-admin cluster join riak@${ARGS}

# Removes node from cluster by name
remove:
	docker exec crypto-riak-node riak-admin cluster leave riak@${ARGS}

# Add acl rule to riak
user:
	@./scripts/add-user.sh

# Enable security and allow password-auth
secure:
	@./scripts/setup-security.sh

# Riak security settings
settings:
	docker exec crypto-riak-node riak-admin security ${ARGS}
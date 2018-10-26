# swarm
OVERLAY_NETWORK=governor-net
GOV_ROOTPATH?=data

# registry
REGISTRY_PASSWORD_COST=12
REGISTRY_USERNAME=admin
REGISTRY_STACK=governor-registry
REGISTRY_URL=127.0.0.1:5050

# etc
PAGER?=less

# help
help:
	$(PAGER) help.md

# initialize environment vars
.PHONY: env source unsource

env:
	./env.sh

source:
	@echo "Run: source ./source.sh"

unsource:
	@echo "Run: source ./unsource.sh"

# swarm control
.PHONY: init up danger-down danger-destroy connect

init: swarm-init registry-init

up: registry-up

danger-down: registry-down

danger-destroy: swarm-destroy

connect: registry-connect

.PHONY: swarm-init swarm-destroy

swarm-init:
	docker swarm init
	docker network create -d overlay $(OVERLAY_NETWORK)

swarm-destroy:
	docker swarm leave --force

.PHONY: registry-init registry-up registry-down registry-connect

registry-init:
	./registry-init.sh $(GOV_ROOTPATH) $(REGISTRY_PASSWORD_COST) $(REGISTRY_USERNAME)

registry-up:
	docker stack deploy -c dc.registry.yaml $(REGISTRY_STACK)

registry-down:
	docker stack rm $(REGISTRY_STACK)

registry-connect:
	docker login $(REGISTRY_URL)

# general
MITHLOND_ROOTPATH?=data

# registry
REGISTRY_PASSWORD_COST=12
REGISTRY_USERNAME=admin
REGISTRY_STACK=mithlond-registry
REGISTRY_URL=127.0.0.1:5050

# router
MITHLOND_HTTP_PORT?=80
MITHLOND_HTTPS_PORT?=443
MITHLOND_TRAEFIK_PORT?=4242
MITHLOND_NETWORK=mithlond-net
ROUTER_STACK=mithlond-router

# etc
PAGER?=less

# help
help:
	@$(PAGER) help.md

# environment
.PHONY: env source unsource

env:
	@./env.sh

source:
	@echo "Run: source ./source.sh"

unsource:
	@echo "Run: source ./unsource.sh"

# control
.PHONY: init up danger-down danger-destroy connect

init: swarm-init registry-init router-init

up: registry-up router-up

danger-down: registry-down router-down

danger-destroy: swarm-destroy

connect: registry-connect

# swarm
.PHONY: swarm-init swarm-destroy

swarm-init:
	docker swarm init
	docker network create -d overlay $(MITHLOND_NETWORK)

swarm-destroy:
	docker swarm leave --force

# registry
.PHONY: registry-init registry-up registry-down registry-connect

registry-init:
	./registry-init.sh $(MITHLOND_ROOTPATH) $(REGISTRY_PASSWORD_COST) $(REGISTRY_USERNAME)

registry-up:
	docker stack deploy -c dc.registry.yaml $(REGISTRY_STACK)

registry-down:
	docker stack rm $(REGISTRY_STACK)

registry-connect:
	docker login $(REGISTRY_URL)

# router
.PHONY: router-init router-up router-down

router-init:
	./router-init.sh $(MITHLOND_ROOTPATH)

router-up:
	docker stack deploy -c dc.router.yaml $(ROUTER_STACK)

router-down:
	docker stack rm $(ROUTER_STACK)

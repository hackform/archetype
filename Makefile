# etc
PAGER?=less

# help
help:
	@$(PAGER) help.md

# environment
.PHONY: env

env:
	@./env.sh

# control
.PHONY: platform init launch danger-land danger-destroy connect

platform: swarm-init

init: registry-init router-init servicedef-gen

launch: registry-up router-up

danger-land: registry-down router-down

danger-destroy: swarm-destroy

connect: registry-connect

# service definitions
.PHONY: servicedef-gen

servicedef-gen:
	./servicedef-gen.sh

# swarm
.PHONY: swarm-init swarm-destroy

swarm-init:
	docker swarm init
	docker network create -d overlay launch-net

swarm-destroy:
	docker swarm leave --force

# registry
REGISTRY_STACK=launch-registry
.PHONY: registry-init registry-up registry-down registry-connect

registry-init:
	./registry-init.sh

registry-up:
	docker stack deploy -c defs/dc.registry.yaml $(REGISTRY_STACK)

registry-down:
	docker stack rm $(REGISTRY_STACK)

registry-connect:
	docker login 127.0.0.1:5050

# router
ROUTER_STACK=launch-router
.PHONY: router-init router-up router-down

router-init:
	./router-init.sh

router-up:
	docker stack deploy -c defs/dc.router.yaml $(ROUTER_STACK)

router-down:
	docker stack rm $(ROUTER_STACK)

# test service
.PHONY: test-up test-down

test-up:
	docker stack deploy -c defs/dc.test.yaml test

test-down:
	docker stack rm test

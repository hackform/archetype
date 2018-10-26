OVERLAY_NETWORK=governor-net
REGISTRY_STACK=governor-registry

# initialize environment vars
.PHONY: env source unsource

env:
	./env.sh

source:
	@echo "Run: source ./source.sh"

unsource:
	@echo "Run: source ./unsource.sh"

# swarm control
.PHONY: init up danger-down danger-destroy init-dirs swarm-init swarm-destroy registry-up

init: init-dirs swarm-init

up: registry-up

danger-down: registry-down

danger-destroy: swarm-destroy

init-dirs:
	mkdir -p data/registry

swarm-init:
	docker swarm init
	docker network create -d overlay $(OVERLAY_NETWORK)

swarm-destroy:
	docker swarm leave --force

registry-up:
	docker stack deploy -c dc.registry.yaml $(REGISTRY_STACK)

registry-down:
	docker stack rm $(REGISTRY_STACK)

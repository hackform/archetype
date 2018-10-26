# Mithlond

## Commands

### Environment

- `make help`: prints this help file
- `make env`: prints the current state of environment variables
- `source ./source.sh`: sets the environment variables needed by docker swarm
- `source ./unsource.sh`: unsets the environment variables set by source.sh

### General

There are three states: uninitialized, initialized, running

- `make init`: brings the env to an initialized state
    - runs `swarm-init`, `registry-init`
- `make up`: brings the env to a running state
    - runs `registry-up`
- `make danger-down`: brings the env from a running to an initialized state
    - runs `registry-down`
- `make danger-destroy`: brings the env to an uninitialized state
    - runs `registry-down`
- `make connect`: for use by a client, establishes connections to a running env

### Swarm

- `swarm-init`: initializes docker swarm and creates an overlay network
- `swarm-destroy`: forces host to leave the docker swarm

### Registry

- `registry-init`: initializes the volume mounts needed by the registry and
  creates an admin user
- `registry-up`: starts the registry service on 127.0.0.1:5050
- `registry-down`: stops the registry service
- `registry-connect`: for use by a client, connects to the registry

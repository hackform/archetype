# launchpad

## Commands

### Environment

- `make help`: prints this help file
- `make env`: prints the current state of environment variables
- `source ./source.sh`: sets the environment variables needed by docker swarm
- `source ./unsource.sh`: unsets the environment variables set by source.sh

### General

There are four states: uninitialized, initialized, configured, running

- `make platform`: brings the env to an initialized state
    - runs `swarm-init`
- `make init`: brings the env to a configured state
    - runs `registry-init`, `router-init`
- `make launch`: brings the env to a running state
    - runs `registry-up`, `router-up`
- `make danger-land`: brings the env from a running to a configured state
    - runs `registry-down`, `router-down`
- `make danger-destroy`: brings the env to an uninitialized state
    - runs `swarm-destroy`
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

### Router

- `router-init`: initializes the volume mounts needed by the router and creates
  default configuration files
- `router-up`: starts the router serivce, listening by default on ports 80 and
  443 for http/https traffic, and 4242 for the admin interface
- `router-down`: stops the router service

### Test

- `test-up`: brings up a test service, accessible via the hostname
  test-whoami.localhost
- `test-down`: stops the test service

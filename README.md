#  Dockerized Golem Network Provider Node 

You can clone this repository of use the provided `docker/Dockerfile` and `docker-compose.yml` as a template for your node.

## Usage

A `Makefile` is provided for convenience, but `make` is not required to run the node.

Use `make` or `make help` to list the available shortcuts.

### First Start

Use `make setup` to run the node for the first time.

The CLI will ask you a few questions: refer to [Golem documentation > Initial setup](https://handbook.golem.network/provider-tutorials/provider-tutorial#initial-setup) for more details.

The node settings will be kept on your host in a `./data-node` repository.

### Start the Node

Use `make up` to start the node in detached mode. You can access the logs at all time by running `make logs`.

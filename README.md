#  Golem Provider Node :whale: Docker Image

> Project submited to the [Run a Provider Node for 14 Days](https://gitcoin.co/issue/golemfactory/yagna/880/100024489) and [Hack New Golem](https://gitcoin.co/issue/golemfactory/hackathons/6/100024411) bounties.
> 
> Testnet Node ID: `0xef72927cde5a9cf2774578050be45c9aaeb4593f`

## :link: Links

- [Github Repository](https://github.com/alexandre-abrioux/golem-node)
- [DockerHub Respository](https://hub.docker.com/r/aabrioux/golem-node)
- [Golem Network > Website](https://golem.network/)
- [Golem Network > Provider Node Documentation](https://handbook.golem.network/provider-tutorials/provider-tutorial)

## :information_source: Prerequisites (important)

As per the [Provider Node Documentation > Prerequisites](https://handbook.golem.network/provider-tutorials/provider-tutorial#prerequisites):

> To run Golem Sneak Peek you'll need a physical machine as you may encounter issues when running it on a virtual machine.

Your Docker host must be a physical machine. Furthermore you will need to give the container access to the `/dev/kvm` device.

## :arrow_forward: Usage

You can clone this repository or use the provided `docker-compose.yml` as a base template for your own setup.

A `Makefile` is included for convenience but `make` is not required to run the node.

Use `make` or `make help` to list the available shortcuts.

### 1. First Start

Use `make setup` to run the node for the first time.

The CLI will ask you a few questions: refer to the [Provider Node Documentation > Initial Setup](https://handbook.golem.network/provider-tutorials/provider-tutorial#initial-setup) for more details.

The node settings will be kept on your host in a `./data-node` repository.

### 2. Run the Node

Use `make up` to start the node in a detached mode.

You can access the logs at any time by running `make logs`.

Use `make status` to get your node address and health.

## Donation :beer:

If you find this template useful you may consider the option of offering me a beer through a donation. Support is very appreciated :slightly_smiling_face:

ETH / ERC20 Token: `0x18f199E8DAb38257ca84D4858FF6F73De1A697eA`

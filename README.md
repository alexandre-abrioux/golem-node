# Golem Provider Node :whale: Docker Image

> Project won one of the four prizes allocated by the Golem Project on Gitcoin's [Hack New Golem](https://gitcoin.co/issue/golemfactory/hackathons/6/100024411) bounty!
>
> Read more on the [Golem's Blog article](https://blog.golemproject.net/meet-the-winners-golem-gitcoin-hackathon-2020/).

## :link: Links

- [Github Repository](https://github.com/alexandre-abrioux/golem-node)
- [DockerHub Respository](https://hub.docker.com/r/aabrioux/golem-node)
- [Golem Network > Website](https://golem.network/)
- [Golem Network > Provider Node Documentation](https://handbook.golem.network/provider-tutorials/provider-tutorial)
- [Golem Network > Yagna Github Repository](https://github.com/golemfactory/yagna)

## :information_source: Prerequisites (important)

As per the [Provider Node Documentation > Prerequisites](https://handbook.golem.network/provider-tutorials/provider-tutorial#prerequisites):

> To run Golem Sneak Peek you'll need a physical machine as you may encounter issues when running it on a virtual machine.

Your Docker host must be a physical machine: you will need to give the container access to the `/dev/kvm` device.

Furthermore, Golem only supports the x86-64 architecture at the moment.
The AArch64 (ARM64) architecture is not supported; see [more details here](https://github.com/alexandre-abrioux/golem-node/issues/44#issuecomment-2211726849).

## :arrow_forward: Usage

You can clone this repository or use the provided `docker-compose.yml` as a base template for your own setup.

A `Makefile` is included for convenience but `make` is not required to run the node.

Use `make` or `make help` to list the available shortcuts.

### 1. Environment Set Up

Create a `.env.local` file in order to add your ERC20 address as an environment variable
(replace the following placeholder with your own **PUBLIC** address):

```bash
echo "YA_ACCOUNT=0x18f199E8DAb38257ca84D4858FF6F73De1A697eA" >> .env.local
```

This is important because it will be the address where your earned GLM will be sent.

You can use for instance your Metamask or Ledger public address.
This way, you can have your earned GLM tokens sent directly to your account,
and you can manage them from there without Golem ever needing to access your wallet.

### 2. First Start

Use `make setup` to run the node for the first time.

The CLI will ask you a few questions: refer to the [Provider Node Documentation > Initial Setup](https://handbook.golem.network/provider-tutorials/provider-tutorial#initial-setup) for more details.

The node settings will be kept on your host in a `./data-node` repository.

### 3. Run the Node

Use `make up` to start the node in a detached mode.

Display the last logs at any time by running `make logs`.

Use `make status` to get your node address and health, and `make settings` to display your current node parameters.

Get shell access with `make shell`.

## :dash: Maintenance

The node caches every docker image it uses to run jobs in the following directory:
`./data-node/ya-provider/exe-unit/cache/`.
Those images are never removed and can slowly take up a lot of space on your hard drive.

To prevent this a helper command has been introduced: `make clean` ;
which removes every file older than 7 days in the cache directory.

If you are running the job scheduler for docker environments [Ofelia](https://github.com/mcuadros/ofelia) on your host
this task will be done automatically, every day at midnight,
thanks to specific labels added on the `node` service.

## Donation :beer:

If you find this template useful you may consider the option of offering me a beer through a donation. Support is very appreciated :slightly_smiling_face:

ETH / ERC20 Token: `0x18f199E8DAb38257ca84D4858FF6F73De1A697eA`

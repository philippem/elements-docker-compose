# elements-docker-compose

Run an [elements](https://github.com/ElementsProject/elements) regtest
network with docker-compose.

Three nodes are launched: a bitcoin node, and two elements nodes. The
elements nodes have test coins.

The node configuration is based on the http://elementsproject.org Code Tutorial at
https://elementsproject.org/elements-code-tutorial/overview

This docker compose configuration provides an alternative to installing elements and
bitcoin nodes locally.

# Pre-requisites

To use this code, you will need to install `docker` and `docker-compose`:

- Docker installation instructions https://docs.docker.com/get-docker
- docker compose installation instructions https://docs.docker.com/compose/install/

If you are installing on Linux, please follow the Linux
post-installation steps at
https://docs.docker.com/engine/install/linux-postinstall/, so that you
can run docker as a non-root user. 

## Running

Build the containers:

```
$ docker compose build
```

Launch the three containers:

```
$ docker compose up -d
```

A bitcoin node running in regtest mode and two elements nodes running in elementsregtest mode are launched.
After a few seconds, the network will be fully connected.

Verify that the three containers are running:

```
$ docker ps
CONTAINER ID   IMAGE                                 COMMAND                  CREATED         STATUS         PORTS                                 NAMES
38719b9d2a03   elements-docker-compose_bitcoind      "/usr/local/bin/bitc…"   3 minutes ago   Up 3 minutes   0.0.0.0:18888->18888/tcp, 18889/tcp   docker-compose-bitcoind
4cf27baea81e   elements-docker-compose_elementsd-1   "/docker-entrypoint.…"   3 minutes ago   Up 3 minutes   0.0.0.0:18884->18884/tcp              docker-compose-elementsd-1
7228e131fa57   elements-docker-compose_elementsd-2   "/docker-entrypoint.…"   3 minutes ago   Up 3 minutes   0.0.0.0:18886->18886/tcp              docker-compose-elementsd-2
```

The daemon RPC ports are exposed to the host and will be listed in the output of `docker ps`.


### Stopping the network
```
$ docker compose down
```

Node data, including chains and wallets, will persist in docker volumes after shutdown.

### Cleanup

```
$ docker compose down -v --remove-orphans
```

will stop all containers and delete all volumes.

## Running Commands


### RPC

The daemons support RPC access and expose their RPC ports to the host. See the `docker-compose.yml` file for credentials.


### Quickstart 

Bash aliases are provided in `aliases.sh`, that allow you run elements
RPC commands on each of the nodes:


```
$ source ./aliases.sh

```

Create a wallet on one elements node, and claim the free coins:

$ e1-cli createwallet '' || true
$ e1-cli rescanblockchain
$ e1-cli getwalletinfo
```

...
{
  "walletname": "",
  "walletversion": 169900,
  "format": "bdb",
  "balance": {
    "bitcoin": 21000000.00000000
  },

```

Create a wallet in the second elements node:

```
$ e2-cli createwallet '' || true
$ e2-cli rescanblockchain
$ e2-cli getwalletinfo
```

### Step-by-step ELements tutorial

You can now continue with the (Elements
Tutorial)[https://elementsproject.org/elements-code-tutorial/basic-operations]


### Complete tutorial steps

The elementsproject.org tutorial is included here as a bash script,
and can be run directly:


```
$ ./tutorial-excerpt.sh
```












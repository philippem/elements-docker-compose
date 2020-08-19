# elements-docker-compose

Run an [elements](https://github.com/ElementsProject/elements) regtest network with docker-compose.

The node configuration is based on the http://elementsproject.org Code Tutorial at
https://elementsproject.org/elements-code-tutorial/overview
and `conf` files defined at https://github.com/ElementsProject/elements/tree/master/contrib/assets_tutorial

## Running

Build the containers:

```
$ docker-compose build
```

### Starting the network

Launch the three containers:

```
$ docker-compose up -d
```

A bitcoin node running in regtest mode and two elements nodes running in elementsregtest mode are launched.
After a few seconds, the network will be fully connected.

Verify that the three containers are running:

```
$ docker ps
CONTAINER ID        IMAGE                                 COMMAND                  CREATED             STATUS              PORTS                                 NAMES
22a22e05e262        elements-docker-compose_elementsd-1   "/docker-entrypoint.…"   2 seconds ago       Up 1 second         0.0.0.0:18884->18884/tcp              elements-docker-compose_elementsd-1_1
f7d2e2b890f2        elements-docker-compose_elementsd-2   "/docker-entrypoint.…"   2 seconds ago       Up 1 second         0.0.0.0:18886->18886/tcp              elements-docker-compose_elementsd-2_1
ec75a4231576        elements-docker-compose_bitcoind      "/usr/local/bin/bitc…"   2 seconds ago       Up 1 second         0.0.0.0:18888->18888/tcp, 18889/tcp   elements-docker-compose_bitcoind_1
```

The daemon RPC ports are exposed to the host and will be listed in the output of `docker ps`.


### Stopping the network
```
$ docker-compose down
```

Node data, including chains and wallets, will persist in docker volumes after shutdown.

### Cleanup

```
$ docker-compose down -v --remove-orphans
```

will stop all containers and delete all volumes.

## Running Commands


### RPC

The daemons support RPC access and expose their RPC ports to the host. See the `docker-compose.yml` file for credentials.


### elementsproject.org style aliases

Bash aliases are provided in `aliases.sh`:

```
$ source ./aliases.sh
$ e1-cli getwalletinfo
```

### Tutorial example

Run a subset of the elementsproject.org tutorial.

```
$ ./tutorial-excerpt.sh
```












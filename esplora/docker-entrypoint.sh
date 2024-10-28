#!/usr/bin/env bash

# bitcoind
wait-for-it.sh 172.16.238.10:18888 -t 0

# elementsd
wait-for-it.sh 172.16.238.11:18886 -t 0

# hack to allow electrs to find the cookie set by elements based on the chain name
mkdir -p /data/liquid
ln -f -s /data/liquid/elementsregtest /data/liquid/liquidregtest

export RUST_BACKTRACE=1
exec /srv/explorer/run.sh $@

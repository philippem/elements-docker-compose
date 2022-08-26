#!/usr/bin/env bash

wait-for-it.sh --host=bitcoind --port=18888 --timeout=0
wait-for-it.sh --host=elementsd-1 --port=18884 --timeout=0

exec /usr/local/bin/elementsd $@

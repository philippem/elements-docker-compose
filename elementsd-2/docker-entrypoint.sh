#!/usr/bin/env bash

set -e

wait-for-it.sh --host=bitcoind --port=18888 --timeout=0

exec /usr/local/bin/elementsd $@

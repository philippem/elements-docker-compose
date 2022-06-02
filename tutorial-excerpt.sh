#!/bin/bash
set -x

shopt -s expand_aliases

source ./aliases.sh



# Wait for bitcoin node to finish startup and respond to commands
until b-cli getchaintips
do
  echo "Waiting for bitcoin node to finish loading..."
  sleep 2
done

# create default wallet if it doesn't exist
b-cli createwallet "" || true
b-cli rescanblockchain
b-cli getwalletinfo


# Wait for e1 node to finish startup and respond to commands
until e1-cli getchaintips
do
  echo "Waiting for e1 to finish loading..."
  sleep 2
done

e1-cli createwallet "" || true
e1-cli rescanblockchain
e1-cli getwalletinfo

# Wait for e2 node to finish startup and respond to commands
until e2-cli getchaintips
do
  echo "Waiting for e2 to finish loading..."
  sleep 2
done

e2-cli createwallet "" || true
e2-cli rescanblockchain
e2-cli getwalletinfo

# Exit on error
set -o errexit

### Basic Operations ###

ADDRGENB=$(b-cli getnewaddress)
ADDRGEN1=$(e1-cli getnewaddress)
ADDRGEN2=$(e2-cli getnewaddress)

e1-cli sendtoaddress $(e1-cli getnewaddress) 21000000 "" "" true
e1-cli generatetoaddress 101 $ADDRGEN1
sleep 10
e1-cli sendtoaddress $(e2-cli getnewaddress) 10500000 "" "" false
e1-cli generatetoaddress 101 $ADDRGEN1
sleep 10

e1-cli getwalletinfo
e2-cli getwalletinfo

ADDR=$(e2-cli getnewaddress)

echo $ADDR

e2-cli getaddressinfo $ADDR

TXID=$(e2-cli sendtoaddress $ADDR 1)

sleep 10

e1-cli getrawmempool
e2-cli getrawmempool
e1-cli getblockcount
e2-cli getblockcount

e2-cli generatetoaddress 1 $ADDRGEN2
sleep 10

e1-cli getrawmempool
e2-cli getrawmempool
e1-cli getblockcount
e2-cli getblockcount

e2-cli gettransaction $TXID

# Ignore error
set +o errexit

echo "This may error - that is ok, not aware of tx"
e1-cli gettransaction $TXID

# Exit on error
set -o errexit

e1-cli getrawtransaction $TXID 1

e1-cli importaddress $ADDR

e1-cli gettransaction $TXID true

e1-cli importblindingkey $ADDR $(e2-cli dumpblindingkey $ADDR)

e1-cli gettransaction $TXID true

### Issued Assets ###

e1-cli getwalletinfo

e1-cli dumpassetlabels

ISSUE=$(e1-cli issueasset 100 1)

ASSET=$(echo $ISSUE | jq -r '.asset')
TOKEN=$(echo $ISSUE | jq -r '.token')
ITXID=$(echo $ISSUE | jq -r '.txid')
IVIN=$(echo $ISSUE | jq -r '.vin')

echo $ASSET

e1-cli listissuances

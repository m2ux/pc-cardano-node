#!/bin/bash

# Generate a payment key pair and an address
docker exec -it -w /host $1 \
cardano-cli address key-gen \
--verification-key-file payment.vkey \
--signing-key-file payment.skey

# Generate a type 6 address, the associated stake of which cannot be delegated
docker exec -it -w /host $1 \
cardano-cli address build \
--payment-verification-key-file payment.vkey \
--out-file payment.addr \
--testnet-magic 2

#!/bin/bash

docker exec -it -w /host $1 \
cardano-cli stake-address key-gen \
--verification-key-file stake.vkey \
--signing-key-file stake.skey

docker exec -it -w /host $1 \
cardano-cli address build \
--payment-verification-key-file payment.vkey \
--stake-verification-key-file stake.vkey \
--out-file paymentwithstake.addr \
--testnet-magic 2

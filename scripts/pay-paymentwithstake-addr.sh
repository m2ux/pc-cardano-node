#!/bin/bash
# Build the transaction
cardano_cli=../scripts/cardano-cli.sh
$cardano_cli transaction build-raw --babbage-era \
--tx-in $($cardano_cli query utxo --address $(cat payment.addr) --testnet-magic 2 --out-file  /dev/stdout | jq -r 'keys[0]') \
--tx-out $(cat paymentwithstake.addr)+5000000000 \
--tx-out $(cat payment.addr)+5000000000 \
--fee 0 \
--protocol-params-file pparams.json \
--out-file tx.draft

# Calculate the minimum fee
$cardano_cli transaction calculate-min-fee --tx-body-file tx.draft \
--testnet-magic 2 \
--protocol-params-file pparams.json \
--tx-in-count 1 \
--tx-out-count 2 \
--witness-count 1 

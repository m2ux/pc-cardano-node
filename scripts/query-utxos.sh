#!/bin/bash
../scripts/cardano-cli.sh query utxo --address $(cat payment.addr) --testnet-magic 2

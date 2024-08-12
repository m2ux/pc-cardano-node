#!/bin/bash
./cardano-cli query utxo --address $(cat payment.addr) --testnet-magic 2

#!/bin/bash
cd $1
../scripts/cardano-cli.sh address build --payment-verification-key-file /host/payment.vkey --testnet-magic 2
cd ..

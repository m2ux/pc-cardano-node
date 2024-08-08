#!/bin/bash
./scripts/gen-payment-kpa.sh
./scripts/gen-stake-kpa.sh
mv *.*key ./data
cd bin
./partner-chains-cli generate-keys
./partner-chains-cli prepare-configuration
mv partner-chains*.json ../data
cd ..
mv partner-chains*.json ./data

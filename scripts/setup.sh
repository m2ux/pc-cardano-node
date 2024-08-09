#!/bin/bash

cd data

../scripts/gen-payment-kpa.sh
../scripts/gen-stake-kpa.sh
#mv *.*key ./data
../bin/partner-chains-cli generate-keys
../bin/partner-chains-cli prepare-configuration

# Insert the permissioned candidate keys into the chain config for this node
cat partner-chains-public-keys.json | ../scripts/insert-ipc.sh partner-chains-cli-chain-config.json

../bin/partner-chains-cli create-chain-spec
../bin/partner-chains-cli setup-main-chain-state
mv partner-chains*.json ../data
#mv chain-spec.json ../data
#cd ..
#mv partner-chains*.json ./data
#cd bin
../bin/partner-chains-cli start-node

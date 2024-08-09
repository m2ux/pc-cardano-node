#!/bin/bash

cd chain-builder

# Symlinks permit binaries to be referenced as local to PWD
ln -s -f ../scripts/cardano-cli.sh cardano-cli
ln -s -f /usr/local/bin/partner-chains-cli partner-chains-cli
ln -s -f /usr/local/bin/partner-chains-node partner-chains-node
ln -s -f /usr/local/bin/sidechain-main-cli sidechain-main-cli

echo -- Partnerchains CLI Generate keys and prepare configuration --

./partner-chains-cli generate-keys
./partner-chains-cli prepare-configuration

# Insert the permissioned candidate keys into the chain config for this node
#cat partner-chains-public-keys.json | ../scripts/insert-ipc.sh partner-chains-cli-chain-config.json

./partner-chains-cli create-chain-spec
./partner-chains-cli setup-main-chain-state
./partner-chains-cli start-node

# Remove symlinks
rm -f cardano-cli
rm -f partner-chains-cli
rm -f partner-chains-node
rm -f sidechain-main-cli

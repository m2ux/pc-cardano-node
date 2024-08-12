#!/bin/bash

cd permissioned-candidate

if [[ ! -f ../chain-builder/chain-spec.json ]] || [[! -f ../chain-builder/partner-chains-cli-chain-config.json ]] ; then
    echo 'Chain configuration missing!'
    echo 'Both chain-spec.json and partner-chains-cli-chain-config.json must be present in the ./chain-builder folder'
    exit
fi

# Acquire the chain configuration from the chain-builder folder
cp ../chain-builder/chain-spec.json .
cp ../chain-builder/partner-chains-cli-chain-config.json .

# Symlinks permit binaries to be referenced as local to PWD
ln -s -f ../scripts/cardano-cli.sh cardano-cli
ln -s -f /usr/local/bin/partner-chains-cli partner-chains-cli
ln -s -f /usr/local/bin/partner-chains-node partner-chains-node
ln -s -f /usr/local/bin/sidechain-main-cli sidechain-main-cli

# Remove legacy artifacts
rm partner-chains-cli-chain-config.json partner-chains-public-keys.json

# Generate public keys and prepare configuration
./partner-chains-cli generate-keys
./partner-chains-cli prepare-configuration

# Remove symlinks
rm -f cardano-cli
rm -f partner-chains-cli
rm -f partner-chains-node
rm -f sidechain-main-cli

partner-chains-cli start-node

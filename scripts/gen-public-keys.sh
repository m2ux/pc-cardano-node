#!/bin/bash

cd ${PWD##*/}

# Symlinks permit binaries to be referenced as local to PWD
ln -s -f ../scripts/cardano-cli.sh cardano-cli
ln -s -f /usr/local/bin/partner-chains-cli partner-chains-cli
ln -s -f /usr/local/bin/partner-chains-node partner-chains-node

rm partner-chains-public-keys.json

echo -- Partnerchains CLI Generate keys  --

./partner-chains-cli generate-keys
# Remove symlinks
rm -f cardano-cli
rm -f partner-chains-cli
rm -f partner-chains-node

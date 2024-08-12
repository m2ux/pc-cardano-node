#!/bin/bash
name=pc_${PWD##*/}
cardano_node_name=${name}-cardano-node-1

env NODE_TYPE=${PWD##*/} docker-compose -p $name up -d
../scripts/gen-payment-kpa.sh ${cardano_node_name}
../scripts/gen-stake-kpa.sh ${cardano_node_name}

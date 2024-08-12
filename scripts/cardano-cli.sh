#!/bin/bash
name=pc_${PWD##*/}
cardano_node_name=${name}-cardano-node-1
docker exec -it -w /host $cardano_node_name cardano-cli "$@"

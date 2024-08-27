#!/bin/bash
name=pc_${PWD##*/}
cardano_node_name=${name}-cardano-node-1

env NODE_TYPE=${PWD##*/} docker-compose -p $name down

#docker ps --filter name=$1* --filter status=running -aq --filter status=restarting | xargs docker-compose down

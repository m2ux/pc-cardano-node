#!/bin/bash
docker ps --filter name=$1* --filter status=running -aq --filter status=restarting | xargs docker stop

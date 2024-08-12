#!/bin/bash
docker ps --filter name=$1* --filter status=running -aq | xargs docker stop

#!/bin/bash
docker-compose up -d
./scripts/gen-payment-kpa.sh
./scripts/gen-stake-kpa.sh

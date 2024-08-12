# Partner Chains Stack: Cardano Node
> [!WARNING]
> This repo is under active development and may be incomplete and/or change without warning

## Purpose

The purpose of this repo is to permit the rapid spin-up of any/all of the three [Partner Chains](https://github.com/input-output-hk/partner-chains) node variants using only the provided setup scripts and with minimal user intervention. These node variants are:

* [Chain Builder](https://github.com/input-output-hk/partner-chains/blob/master/docs/user-guides/chain-builder.md)
* [Permissioned Candidate](https://github.com/input-output-hk/partner-chains/blob/master/docs/user-guides/permissioned.md)
* [Registered Block Producer](https://github.com/input-output-hk/partner-chains/blob/master/docs/user-guides/registered.md)

It includes a unified multi-application Docker configuration to encapsulate all dependencies of the partner chains stack:

* `cardano-node` 
* `cardano-db-sync`
* `postgres` 
* `ogmios`
* `kupo`
* `dozzle`

## Enviroment Setup
1, The repo should be checked out and all contained submodules initialised as follows:

```git clone https://github.com/m2ux/pc-cardano-node && git submodule init```

> [!NOTE]
> The latest versions of the following dependencies should be installed before attempting any PC node related operations:
>
> * `git`
> * `docker`
> * `docker-compose`

2, Ensure that the binaries from the [Partnerchains Node release package](https://github.com/input-output-hk/partner-chains/releases/tag/v1.0.0) are available at:

* `usr/local/bin/partner-chains-node`
* `usr/local/bin/partner-chains-cli`
* `usr/local/bin/sidechain-main-cli`

## Node Types

Any reference henceforth to `node-type` corresponds to one of the following three verbatim types:

* `chain-builder`
* `permissioned-candidate`
* `registered-block-producer`

These are succinctly referred to in body text as **CB**, **PC** and **RBP**

## Node Operations

### Start a Cardano Node
A cardano-node may be created/started with:

`./start-cardano-node <node-type>`

> [!NOTE]
> Once the node is up and running, the following services are available @ localhost:**port**:
> 
> * Ogmios dashboard: **1337**
> * Kupo server: **1442** 
> * DB-Sync PostgreSQL server: **5432**
> * Dozzle Docker-log-monitor server: **8080**
> * Cardano Node EKG-metrics server: **12788**
>
> The exact port numbers above **vary depending on the node type** and are pre-configured in the file: `.env` in *each* of the respective node-type folders.

### Stop a Cardano Node

To stop a running cardano node, the following command may be issued: 

`./stop-cardano-node <node-type>`

### Generate PC Node Public Keys

Public keys for any node type may be generated with:

`./gen-public-keys <node-type>`

> [!IMPORTANT]
> Prior to commencing setup of a CB node, the public keys of any/all permissioned validators must be present.

### Setup Partnerchains Node

In order to setup a given partnerchains node type, run:

`./setup-pc-node <node-type>`

## Cluster Operations

### Tri-node Setup (1CB + 1PC + 1RBP)

The following sequence of operations will spin-up a cluster containing one of each node type running in a single host environment:

```
./start-cardano-node chain-builder && ./start-cardano-node permissioned-candidate && ./gen-public-keys permissioned-candidate
./setup-pc-node chain-builder && ./setup-pc-node chain-builder && ./setup-pc-node registered-block-producer
```
> [!NOTE]
> The primary use case envisaged for this confgiruation is PC testing & development
### Misc. scripts

To [generate payment keys and addresses](https://cardano-course.gitbook.io/cardano-course/handbook/building-and-running-the-node/create-keys-and-addresses#generating-a-payment-key-pair-and-an-address) for the node:
```
./scripts/gen-payment-kpa.sh
```
To [generate stake keys and addresses](https://cardano-course.gitbook.io/cardano-course/handbook/building-and-running-the-node/create-keys-and-addresses#generating-a-stake-key-pair-and-a-type-0-address) for the node:
```
./scripts/gen-stake-kpa.sh
```
To [query UTXOs for the payment address](https://cardano-course.gitbook.io/cardano-course/handbook/building-and-running-the-node/create-keys-and-addresses#querying-the-address-balance) after [recieving funds from the testnet faucet](https://docs.cardano.org/cardano-testnet/tools/faucet):
```
./scripts/query-utxos.sh
```

## System Requirements

The system requirements for running the above components on the same machine are:

* Any of the big well known Linux distributions (eg, Debian, Ubuntu, RHEL, CentOS, Arch
  etc).
* 32 Gigabytes of RAM or more.
* 4 CPU cores or more.
* Ensure that the machine has sufficient IOPS (Input/Output Operations per Second). Ie it should be
  60k IOPS or better. Lower IOPS ratings will result in slower sync times and/or falling behind the
  chain tip.
* 320 Gigabytes or more of disk storage (preferably SSD which are 2-5 times faster than
  electro-mechanical disks).

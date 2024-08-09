# Partner Chains Stack: Cardano Node
> [!WARNING]
> This repo is under heavy development and may be incomplete and/or change without warning

## Purpose

The purpose of this repo is to permit the rapid spin-up of any/all of the three partnerchains node variants using only the provided setup scripts and with minimal user intervention. These node variants are:

* [Chain Builder](https://github.com/input-output-hk/partner-chains/blob/master/docs/user-guides/chain-builder.md)
* [Permissioned Candidate](https://github.com/input-output-hk/partner-chains/blob/master/docs/user-guides/permissioned.md)
* [Registered Block Producer](https://github.com/input-output-hk/partner-chains/blob/master/docs/user-guides/registered.md)

It includes a unified multi-application Docker configuration to encapsulate all of those dependencies of the [Partner Chains](https://github.com/input-output-hk/partner-chains) stack which are co-located with the Cardano node:

* `cardano-node` 
* `cardano-db-sync`
* `postgres` 
* `ogmios`
* `kupo`
* `dozzle`

### Usage

#### Pre-amble
The repo should be checked out and all contained submodules initialised as follows:

```git clone https://github.com/m2ux/pc-cardano-node && git submodule init```

> [!NOTE]
> In order to bring-up a working cardano node, the latest versions of the following dependencies should be installed beforehand:
>
> * `git`
> * `docker`
> * `docker-compose`

#### Setup Cardano Node

Once this is complete, the cardano-node may be activated with:

`./start-cardano-node`

> [!NOTE]
> Once the node is up and running, the following services are available @ localhost:**port**:
> 
> * Ogmios dashboard: **1337**
> * Kupo server: **1442** 
> * DB-Sync PostgreSQL server: **5432**
> * Dozzle Docker-log-monitor server: **8080**
> * Cardano Node EKG-metrics server: **12788**

To subsequently stop the node, the following command may be issued: 

`./stop-cardano-node`

#### Setup Partnerchains Node (Any)

Check that the binaries from the [Partnerchains Node release package](https://github.com/input-output-hk/partner-chains/releases/tag/v1.0.0) are available at:

* `usr/local/bin/partner-chains-node`
* `usr/local/bin/partner-chains-cli`
* `usr/local/bin/sidechain-main-cli`

> [!IMPORTANT]
> These should be installed *before* attempting any partnerchain node-related operations.

#### Setup Partnerchains Node (Chain Builder)

In order to spin-up a chain-builder node, run:

`./setup-chain-builder`

> [!IMPORTANT]
> Before setting up a chain-builder node, the folder `./permissioned-candidate` should contain a public key file (`partner-chains-public-keys-<x>.json`) for every permissioned-candidate to be added to the chain-builders PC list.

#### Setup Partnerchains Node (Permissioned Candidate)

In order to spin-up a permissioned-candidate node, run:

`./setup-perm-candidate`

> [!IMPORTANT]
> Before setting up a permissioned-candidate node, the folder `./chain-builder` should contain a chain specification file (`chain-spec.json`) and a chain configuration (`partner-chains-cli-chain-config.json`) file.

#### Setup Partnerchains Node (Registered Block Producer)

In order to spin-up a registered-block-producer node, run:

`./setup-registered-block-producer`

> [!IMPORTANT]
> Before setting up a registered-block-producer node, the folder `./chain-builder` should contain a chain specification file (`chain-spec.json`) and a chain configuration (`partner-chains-cli-chain-config.json`) file.

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
### Connectivity

A typical use case might be to run these on e.g. an AWS EC2 instance and then tunnel ports 1337, 1442 & 5432 over SSH to a local machine running the Partner Chains node.

A typical SSH command specification to achieve this is (assuming aws_cardano_node_1.pem is your SSH priv key):

```
ssh -i ~/.ssh/aws_cardano_node_1.pem -N -L 1337:localhost:1337 -L 1442:localhost:1442 -L 5432:localhost:5432 ec2-user@ec2-10-49-200-200.eu-north-1.compute.amazonaws.com
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

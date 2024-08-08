# Partner Chains Stack: Cardano Node

## Purpose

The purpose of this repo is to provide a unified multi-application Docker configuration to run those dependencies of the [Partner Chains](https://github.com/input-output-hk/partner-chains) stack which are co-located with the Cardano node:

* `cardano-node` 
* `cardano-db-sync`
* `postgres` 
* `ogmios`
* `kupo`
* `dozzle`

Once up and running, the following services are available @ localhost:**port**:

* Ogmios dashboard: **1337**
* Kupo server: **1442** 
* DB-Sync PostgreSQL server: **5432**
* Dozzle Docker-log-monitor server: **8080**
* Cardano Node EKG-metrics server: **12788**

### Usage

Once cloned, use the following command to create/start all containers (in daemon mode):
```
./start-node
```
To subsequently stop all running containers, use:
```
./stop-node.sh
```
To access the cardano-node CLI run the following script. Any arguments provided will be passed through to `cardano-cli`:
```
./cardano-cli.sh
```
To [generate payment keys and addresses](https://cardano-course.gitbook.io/cardano-course/handbook/building-and-running-the-node/create-keys-and-addresses#generating-a-payment-key-pair-and-an-address) for the node:
```
./gen-payment-kpa
```
To [generate stake keys and addresses](https://cardano-course.gitbook.io/cardano-course/handbook/building-and-running-the-node/create-keys-and-addresses#generating-a-stake-key-pair-and-a-type-0-address) for the node:
```
./gen-stake-kpa
```
To [query UTXOs for the payment address](https://cardano-course.gitbook.io/cardano-course/handbook/building-and-running-the-node/create-keys-and-addresses#querying-the-address-balance) after [recieving funds from the testnet faucet](https://docs.cardano.org/cardano-testnet/tools/faucet):
```
./query-utxos
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

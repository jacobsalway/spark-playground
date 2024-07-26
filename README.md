# spark-infra

Run Spark on Kubernetes on a local Kubernetes cluster using Kind. It includes the following:

- [Spark operator](https://github.com/kubeflow/spark-operator)
- [Apache YuniKorn](https://yunikorn.apache.org/)

## Setup

- Run `make setup` to create a Kind cluster and install all the addons.
- Run `make help` to view all the available targets.

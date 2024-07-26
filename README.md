# spark-infra

Run Spark on Kubernetes on a local Kubernetes cluster using Kind.

## Setup

Run `make setup` to create a Kind cluster and install all the addons. Run `make help` to view all the available targets.

```
Usage:
  make <target>
  help             Display help
  setup            Create a Kind cluster and install all the addons

Kind
  create-cluster   Create a Kind cluster
  delete-cluster   Delete the Kind cluster

Addons
  addons           Install all the addons
  yunikorn         Install Yunikorn
```

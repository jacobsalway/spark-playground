# spark-infra

Run Spark on Kubernetes on a local Kubernetes cluster using Kind. It includes the following:

- [Spark Operator](https://github.com/kubeflow/spark-operator)
- [Apache YuniKorn](https://yunikorn.apache.org/)

## How to run

`kind create cluster --wait=1m && helmfile sync`

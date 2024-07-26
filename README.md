# spark-infra

Run Spark on Kubernetes on a local Kubernetes cluster using Kind. It includes the following:

- [Spark operator](https://github.com/kubeflow/spark-operator)
- [Apache YuniKorn](https://yunikorn.apache.org/)
- [Ingress NGINX controller](https://github.com/kubernetes/ingress-nginx)
- [Prometheus and Grafana](https://github.com/prometheus-community/helm-charts/blob/main/charts/kube-prometheus-stack/README.md)

## Setup

- Run `make setup` to create a Kind cluster and install all addons.
- Run `make help` to view all the available targets.

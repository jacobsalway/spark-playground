help: ## Display help
	@awk 'BEGIN {FS = ":.*##"; printf "Usage:\n  make \033[36m<target>\033[0m\n"} /^[a-zA-Z_0-9-]+:.*?##/ { printf "  \033[36m%-15s\033[0m %s\n", $$1, $$2 } /^##@/ { printf "\n\033[1m%s\033[0m\n", substr($$0, 5) } ' $(MAKEFILE_LIST)

setup: ## Create a Kind cluster and install all addons
	$(MAKE) create-cluster addons

##@ Kind

create-cluster: ## Create a Kind cluster
	kind create cluster --config=kind-config.yaml --wait 1m

delete-cluster: ## Delete the Kind cluster
	kind delete cluster

##@ Addons

addons: ## Install all addons
	$(MAKE) yunikorn spark-operator ingress-nginx

yunikorn: ## Install Yunikorn
	helm upgrade --install \
		--namespace yunikorn --create-namespace --wait --wait-for-jobs \
		--repo https://apache.github.io/yunikorn-release --version 1.5.1 \
		yunikorn yunikorn

spark-operator: ## Install Spark operator
	helm upgrade --install \
		--namespace spark-operator --create-namespace --wait --wait-for-jobs \
		--repo https://kubeflow.github.io/spark-operator --version 1.4.5 \
		spark-operator spark-operator

ingress-nginx: ## Install ingress NGINX controller
	kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/main/deploy/static/provider/kind/deploy.yaml
	kubectl wait pods -n ingress-nginx -l app.kubernetes.io/component=controller --for condition=Ready --timeout=5m

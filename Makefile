help: ## Display help
	@awk 'BEGIN {FS = ":.*##"; printf "Usage:\n  make \033[36m<target>\033[0m\n"} /^[a-zA-Z_0-9-]+:.*?##/ { printf "  \033[36m%-15s\033[0m %s\n", $$1, $$2 } /^##@/ { printf "\n\033[1m%s\033[0m\n", substr($$0, 5) } ' $(MAKEFILE_LIST)

setup: ## Create a Kind cluster and install all the addons
	$(MAKE) create-cluster addons

##@ Kind

create-cluster: ## Create a Kind cluster
	kind create cluster --config=kind-config.yaml --wait 1m

delete-cluster: ## Delete the Kind cluster
	kind delete cluster

##@ Addons

addons: ## Install all the addons
	$(MAKE) yunikorn

yunikorn: ## Install Yunikorn
	helm upgrade --install \
		--namespace yunikorn --create-namespace --wait \
		--repo https://apache.github.io/yunikorn-release --version 1.5.1 \
		yunikorn yunikorn

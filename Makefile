help: ## Display help
	@awk 'BEGIN {FS = ":.*##"; printf "Usage:\n  make \033[36m<target>\033[0m\n"} /^[a-zA-Z_0-9-]+:.*?##/ { printf "  \033[36m%-15s\033[0m %s\n", $$1, $$2 } /^##@/ { printf "\n\033[1m%s\033[0m\n", substr($$0, 5) } ' $(MAKEFILE_LIST)

setup: ## Create a Kind cluster and install all addons
	$(MAKE) create addons

##@ Kind

create: ## Create a Kind cluster
	kind create cluster --config=kind-config.yaml --wait 1m

delete: ## Delete the Kind cluster
	kind delete cluster

##@ Addons

addons: ## Install all addons using helmfile
	helmfile sync	

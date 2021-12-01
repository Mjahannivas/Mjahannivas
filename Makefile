# HELP
# This will output the help for each task
# thanks to https://marmelab.com/blog/2016/02/29/auto-documented-makefile.html
.PHONY: help

help: ## This help.
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

.DEFAULT_GOAL := help

NAMESPACE=boutique
MICROSERVICES_FOLDER=./microservices

PRIVATE_KEY_CERT=/home/ubuntu/aspen-demo-private-key.pem
WILDCARD_CERT=/home/ubuntu/aspen-demo-wildcard-cert.pem

########################
##### DOCKER TASKS #####
########################

build: ## Build all the containers
		cd ${MICROSERVICES_FOLDER}/adservice && $(MAKE) build
		cd ${MICROSERVICES_FOLDER}/cartservice && $(MAKE) build
		cd ${MICROSERVICES_FOLDER}/checkoutservice && $(MAKE) build
		cd ${MICROSERVICES_FOLDER}/currencyservice && $(MAKE) build
		cd ${MICROSERVICES_FOLDER}/emailservice && $(MAKE) build
		cd ${MICROSERVICES_FOLDER}/frontend && $(MAKE) build
		cd ${MICROSERVICES_FOLDER}/loadgenerator && $(MAKE) build
		cd ${MICROSERVICES_FOLDER}/paymentservice && $(MAKE) build
		cd ${MICROSERVICES_FOLDER}/productcatalogservice && $(MAKE) build
		cd ${MICROSERVICES_FOLDER}/recommendationservice && $(MAKE) build
		cd ${MICROSERVICES_FOLDER}/shippingservice && $(MAKE) build

build-nc: ## Build all the containers without caching
		cd ${MICROSERVICES_FOLDER}/adservice && $(MAKE) build-nc
		cd ${MICROSERVICES_FOLDER}/cartservice && $(MAKE) build-nc
		cd ${MICROSERVICES_FOLDER}/checkoutservice && $(MAKE) build-nc
		cd ${MICROSERVICES_FOLDER}/currencyservice && $(MAKE) build-nc
		cd ${MICROSERVICES_FOLDER}/emailservice && $(MAKE) build-nc
		cd ${MICROSERVICES_FOLDER}/frontend && $(MAKE) build-nc
		cd ${MICROSERVICES_FOLDER}/loadgenerator && $(MAKE) build-nc
		cd ${MICROSERVICES_FOLDER}/paymentservice && $(MAKE) build-nc
		cd ${MICROSERVICES_FOLDER}/productcatalogservice && $(MAKE) build-nc
		cd ${MICROSERVICES_FOLDER}/recommendationservice && $(MAKE) build-nc
		cd ${MICROSERVICES_FOLDER}/shippingservice && $(MAKE) build-nc

release: build-nc publish ## Make a release by building and publishing all `{version}` and `latest` tagged containers
		cd ${MICROSERVICES_FOLDER}/adservice && $(MAKE) release
		cd ${MICROSERVICES_FOLDER}/cartservice && $(MAKE) release
		cd ${MICROSERVICES_FOLDER}/checkoutservice && $(MAKE) release
		cd ${MICROSERVICES_FOLDER}/currencyservice && $(MAKE) release
		cd ${MICROSERVICES_FOLDER}/emailservice && $(MAKE) release
		cd ${MICROSERVICES_FOLDER}/frontend && $(MAKE) release
		cd ${MICROSERVICES_FOLDER}/loadgenerator && $(MAKE) release
		cd ${MICROSERVICES_FOLDER}/paymentservice && $(MAKE) release
		cd ${MICROSERVICES_FOLDER}/productcatalogservice && $(MAKE) release
		cd ${MICROSERVICES_FOLDER}/recommendationservice && $(MAKE) release
		cd ${MICROSERVICES_FOLDER}/shippingservice && $(MAKE) release

publish: publish-latest publish-version ## Publish all `{version}` and `latest` tagged containers
		cd ${MICROSERVICES_FOLDER}/adservice && $(MAKE) publish
		cd ${MICROSERVICES_FOLDER}/cartservice && $(MAKE) publish
		cd ${MICROSERVICES_FOLDER}/checkoutservice && $(MAKE) publish
		cd ${MICROSERVICES_FOLDER}/currencyservice && $(MAKE) publish
		cd ${MICROSERVICES_FOLDER}/emailservice && $(MAKE) publish
		cd ${MICROSERVICES_FOLDER}/frontend && $(MAKE) publish
		cd ${MICROSERVICES_FOLDER}/loadgenerator && $(MAKE) publish
		cd ${MICROSERVICES_FOLDER}/paymentservice && $(MAKE) publish
		cd ${MICROSERVICES_FOLDER}/productcatalogservice && $(MAKE) publish
		cd ${MICROSERVICES_FOLDER}/recommendationservice && $(MAKE) publish
		cd ${MICROSERVICES_FOLDER}/shippingservice && $(MAKE) publish

publish-latest: tag-latest ## Publish all `latest` tagged container
		cd ${MICROSERVICES_FOLDER}/adservice && $(MAKE) publish-latest
		cd ${MICROSERVICES_FOLDER}/cartservice && $(MAKE) publish-latest
		cd ${MICROSERVICES_FOLDER}/checkoutservice && $(MAKE) publish-latest
		cd ${MICROSERVICES_FOLDER}/currencyservice && $(MAKE) publish-latest
		cd ${MICROSERVICES_FOLDER}/emailservice && $(MAKE) publish-latest
		cd ${MICROSERVICES_FOLDER}/frontend && $(MAKE) publish-latest
		cd ${MICROSERVICES_FOLDER}/loadgenerator && $(MAKE) publish-latest
		cd ${MICROSERVICES_FOLDER}/paymentservice && $(MAKE) publish-latest
		cd ${MICROSERVICES_FOLDER}/productcatalogservice && $(MAKE) publish-latest
		cd ${MICROSERVICES_FOLDER}/recommendationservice && $(MAKE) publish-latest
		cd ${MICROSERVICES_FOLDER}/shippingservice && $(MAKE) publish-latest

publish-version: tag-version ## Publish all `{version}` tagged containers
		cd ${MICROSERVICES_FOLDER}/adservice && $(MAKE) publish-version
		cd ${MICROSERVICES_FOLDER}/cartservice && $(MAKE) publish-version
		cd ${MICROSERVICES_FOLDER}/checkoutservice && $(MAKE) publish-version
		cd ${MICROSERVICES_FOLDER}/currencyservice && $(MAKE) publish-version
		cd ${MICROSERVICES_FOLDER}/emailservice && $(MAKE) publish-version
		cd ${MICROSERVICES_FOLDER}/frontend && $(MAKE) publish-version
		cd ${MICROSERVICES_FOLDER}/loadgenerator && $(MAKE) publish-version
		cd ${MICROSERVICES_FOLDER}/paymentservice && $(MAKE) publish-version
		cd ${MICROSERVICES_FOLDER}/productcatalogservice && $(MAKE) publish-version
		cd ${MICROSERVICES_FOLDER}/recommendationservice && $(MAKE) publish-version
		cd ${MICROSERVICES_FOLDER}/shippingservice && $(MAKE) publish-version

tag: tag-latest tag-version ## Generate all container tags for the `{version}` ans `latest` tags
		cd ${MICROSERVICES_FOLDER}/adservice && $(MAKE) tag
		cd ${MICROSERVICES_FOLDER}/cartservice && $(MAKE) tag
		cd ${MICROSERVICES_FOLDER}/checkoutservice && $(MAKE) tag
		cd ${MICROSERVICES_FOLDER}/currencyservice && $(MAKE) tag
		cd ${MICROSERVICES_FOLDER}/emailservice && $(MAKE) tag
		cd ${MICROSERVICES_FOLDER}/frontend && $(MAKE) tag
		cd ${MICROSERVICES_FOLDER}/loadgenerator && $(MAKE) tag
		cd ${MICROSERVICES_FOLDER}/paymentservice && $(MAKE) tag
		cd ${MICROSERVICES_FOLDER}/productcatalogservice && $(MAKE) tag
		cd ${MICROSERVICES_FOLDER}/recommendationservice && $(MAKE) tag
		cd ${MICROSERVICES_FOLDER}/shippingservice && $(MAKE) tag

tag-latest: ## Generate all containers `{version}` tag
		cd ${MICROSERVICES_FOLDER}/adservice && $(MAKE) tag-latest
		cd ${MICROSERVICES_FOLDER}/cartservice && $(MAKE) tag-latest
		cd ${MICROSERVICES_FOLDER}/checkoutservice && $(MAKE) tag-latest
		cd ${MICROSERVICES_FOLDER}/currencyservice && $(MAKE) tag-latest
		cd ${MICROSERVICES_FOLDER}/emailservice && $(MAKE) tag-latest
		cd ${MICROSERVICES_FOLDER}/frontend && $(MAKE) tag-latest
		cd ${MICROSERVICES_FOLDER}/loadgenerator && $(MAKE) tag-latest
		cd ${MICROSERVICES_FOLDER}/paymentservice && $(MAKE) tag-latest
		cd ${MICROSERVICES_FOLDER}/productcatalogservice && $(MAKE) tag-latest
		cd ${MICROSERVICES_FOLDER}/recommendationservice && $(MAKE) tag-latest
		cd ${MICROSERVICES_FOLDER}/shippingservice && $(MAKE) tag-latest

tag-version: ## Generate all containers `latest` tag
		cd ${MICROSERVICES_FOLDER}/adservice && $(MAKE) tag-version
		cd ${MICROSERVICES_FOLDER}/cartservice && $(MAKE) tag-version
		cd ${MICROSERVICES_FOLDER}/checkoutservice && $(MAKE) tag-version
		cd ${MICROSERVICES_FOLDER}/currencyservice && $(MAKE) tag-version
		cd ${MICROSERVICES_FOLDER}/emailservice && $(MAKE) tag-version
		cd ${MICROSERVICES_FOLDER}/frontend && $(MAKE) tag-version
		cd ${MICROSERVICES_FOLDER}/loadgenerator && $(MAKE) tag-version
		cd ${MICROSERVICES_FOLDER}/paymentservice && $(MAKE) tag-version
		cd ${MICROSERVICES_FOLDER}/productcatalogservice && $(MAKE) tag-version
		cd ${MICROSERVICES_FOLDER}/recommendationservice && $(MAKE) tag-version
		cd ${MICROSERVICES_FOLDER}/shippingservice && $(MAKE) tag-version

stop: ## Stop and remove all running container
		cd ${MICROSERVICES_FOLDER}/adservice && $(MAKE) stop 2>/dev/null || true
		cd ${MICROSERVICES_FOLDER}/cartservice && $(MAKE) stop 2>/dev/null || true
		cd ${MICROSERVICES_FOLDER}/checkoutservice && $(MAKE) stop 2>/dev/null || true
		cd ${MICROSERVICES_FOLDER}/currencyservice && $(MAKE) stop 2>/dev/null || true
		cd ${MICROSERVICES_FOLDER}/emailservice && $(MAKE) stop 2>/dev/null || true
		cd ${MICROSERVICES_FOLDER}/frontend && $(MAKE) stop 2>/dev/null || true
		cd ${MICROSERVICES_FOLDER}/loadgenerator && $(MAKE) stop 2>/dev/null || true
		cd ${MICROSERVICES_FOLDER}/paymentservice && $(MAKE) stop 2>/dev/null || true
		cd ${MICROSERVICES_FOLDER}/productcatalogservice && $(MAKE) stop 2>/dev/null || true
		cd ${MICROSERVICES_FOLDER}/recommendationservice && $(MAKE) stop 2>/dev/null || true
		cd ${MICROSERVICES_FOLDER}/shippingservice && $(MAKE) stop 2>/dev/null || true

run: ## Run the full demo with docker-compose
		docker-compose up


############################
##### KUBERNETES TASKS #####
############################

install_certificate: ## Install the certificate for secure ingress
	kubectl create secret tls --namespace aspenmesh boutique-boutique --key ${PRIVATE_KEY_CERT} --cert ${WILDCARD_CERT}

kubernetes_install: ## Install boutique application using kubectl
		kubectl apply -f ./kubernetes --namespace ${NAMESPACE}

kubernetes_remove: ## Remove boutique application using kubectl
		kubectl delete -f ./kubernetes --namespace ${NAMESPACE}


######################
##### HELM TASKS #####
######################

# helm_install: ## Install boutique application using helm
# 		kubectl apply -f ./helm/namespace.yaml
# 		helm install boutique ./helm/boutique --namespace ${NAMESPACE} --values ./helm/boutique/values.yaml

# helm_upgrade: ## Upgrade boutique application using helm
# 		kubectl apply -f ./helm/namespace.yaml
# 		helm upgrade boutique ./helm/boutique --namespace ${NAMESPACE} --values ./helm/boutique/values.yaml

# helm_remove: ## Remove boutique application using helm
# 		helm uninstall boutique --namespace ${NAMESPACE}
# 		kubectl delete -f ./helm/namespace.yaml

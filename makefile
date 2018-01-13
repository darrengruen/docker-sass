-include make_env

DEV_TAG = local-dev
NAMESPACE = gruen
IMAGE = sass

DEV_IMAGE = $(NAMESPACE)/$(IMAGE):$(DEV_TAG)_$$(git rev-parse --abbrev-ref HEAD)


build: ## Create a build based on current git branch
	docker build \
		--build-args GIT_SHA=$$(git rev-parse --short HEAD) \
		--build-args BUILD_DATE=$$(date +%Y-%m-%d_%H:%M.%s) \
		-t $(NAMESPACE)/$(IMAGE):$$(git rev-parse --abbrev-ref HEAD) \
		.

buildlocal: ## Build a local test version tagged "local-dev"
	docker build \
		--build-arg BUILD_DATE=local_dev_no_date \
		--build-arg GIT_SHA=local_dev_no_sha \
		-t $(DEV_IMAGE) \
		.

cleandev: ## Cleans up the local dev images. This forcefully stops containers
	docker rm -f $(DEV_IMAGE)

default: help

help: ## Show help file
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "- \033[36m%-20s\033[0m %s\n", $$1, $$2}' ${MAKEFILE_LIST}

pull: ## Pull the latest version of this image
	docker pull $(NAMESPACE)/$(IMAGE)

test: ## Run a quick test on locally built image
	docker run -it --rm \
		--name test_run_$(NAMESPACE)_$(IMAGE)_$$(date +%s) \
		$(DEV_IMAGE) -v


testbuild: buildlocal test ## Builds dev image and runs test

update: pull
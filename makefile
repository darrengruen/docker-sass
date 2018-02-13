BUILD_DATE = $$(date -u +%FT%T.%S%Z)
NAMESPACE = gruen
IMAGE = sass
GIT_SHA = $$(git rev-parse --short HEAD)
FILTER = "label=org.schema-label.name=sass"
TAG = $$(git rev-parse --abbrev-ref HEAD)
IMAGE_NAME = $(NAMESPACE)/$(IMAGE):$(TAG)

build: .build ## Build the image

clean: .clean ## Clear all image/containers related to this image

help: .help ## Output this help file

.build: 
	@docker build \
		--build-arg GIT_SHA=$(GIT_SHA) \
		--build-arg BUILD_DATE=$(BUILD_DATE) \
		-t $(IMAGE_NAME) \
		.

.clean:
    ifneq ($(shell docker ps -a -f $(FILTER) --format "{{.Names}}"),)
	@docker rm -f $(shell docker ps  -a -f $(FILTER) --format "{{.Names}}")
    endif

    ifneq ($(shell docker images -f $(FILTER) --format "{{.ID}}"),)
	@docker rmi -f $(shell docker images -f $(FILTER) --format "{{.ID}}")
    endif

help: ## Show help file
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "- \033[36m%-20s\033[0m %s\n", $$1, $$2}' ${MAKEFILE_LIST}


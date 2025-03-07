HUGO_URI := -tags extended github.com/gohugoio/hugo@v0.143.1

.PHONY: build
build: ## Build application
	CGO_ENABLED=1 go run ${HUGO_URI} --minify
	echo "sspserver.org" > public/CNAME

.PHONY: tidy
tidy: ## Tidy up dependencies
	go mod tidy

.PHONY: run
run: ## Run application
	go run ${HUGO_URI} server --disableFastRender

.PHONY: pull-submodules
pull-submodules: ## Pull submodules
	git submodule update --recursive --remote

.PHONY: help
help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

.DEFAULT_GOAL := help

.GODEPS:
	go install -tags extended github.com/gohugoio/hugo@latest

.PHONY: build
build: .GODEPS ## Build application
	hugo --minify
	echo "sspserver.org" > public/CNAME

.PHONY: tidy
tidy: ## Tidy up dependencies
	go mod tidy

.PHONY: run
run: ## Run application
	hugo server --disableFastRender

.PHONY: help
help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

.DEFAULT_GOAL := help

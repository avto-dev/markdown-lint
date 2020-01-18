#!/usr/bin/make
# Makefile readme (ru): <http://linux.yaroslavl.ru/docs/prog/gnu_make_3-79_russian_manual.html>
# Makefile readme (en): <https://www.gnu.org/software/make/manual/html_node/index.html#SEC_Contents>

docker_bin := $(shell command -v docker 2> /dev/null)
image_name = markdown-lint:local

SHELL = /bin/sh

.PHONY : help build test shell clean
.DEFAULT_GOAL : help

# This will output the help for each task. thanks to https://marmelab.com/blog/2016/02/29/auto-documented-makefile.html
help: ## Show this help
	@printf "\033[33m%s:\033[0m\n" 'Available commands'
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "  \033[32m%-18s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

build: ## Build docker image with application
	$(docker_bin) build --tag $(image_name) -f Dockerfile .

test: ## Execute tests
	$(docker_bin) run --rm -t -v "$(shell pwd)/tests:/tests" -w "/tests" --entrypoint "" $(image_name) /tests/run.sh

shell: ## Start shell into container
	$(docker_bin) run --rm -ti --entrypoint "" $(image_name) sh

clean: ## Make some clean
	$(docker_bin) rmi -f $(image_name)

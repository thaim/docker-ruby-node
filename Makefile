GROUP=thaim
NAME=ruby-nodejs
IMAGE=$(GROUP)/$(NAME)

REV = $(shell git rev-parse --short HEAD)
TAG = $(shell git log -1 --format='%cd' --date=format:%Y%m%d-%H%M)-$(REV)

.PHONY: help build push

help: ## このヘルプメッセージを表示
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {sub("\\\\n",sprintf("\n%22c"," "), $$2);printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

build: ## Dockerイメージを生成する
	docker build -t $(IMAGE):latest \
				 -t $(IMAGE):$(TAG) .

push: ## 生成したDockerイメージをRegistryに保存する
	docker push $(IMAGE):latest
	docker push $(IMAGE):$(TAG)

save: ## 生成したDockerイメージをファイルに保存する
	docker save $(IMAGE) > $(GROUP)_$(NAME)_$(TAG).tar
	docker save $(IMAGE) > $(GROUP)_$(NAME)_latest.tar

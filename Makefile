TOP_DIR=.
VERSION=$(strip $(shell cat version))

dep:
	@echo "Install dependencies required for this repo..."
	@cd src; mix deps.get

build:
	@echo "Building the software..."
	@export ERLANG_ROCKSDB_OPTS="-DWITH_ZSTD=ON"; cd src; mix compile

travis-linux-init:
	@echo "Initialize software required for travis"

travis-darwin-init:
	@echo "Initialize software required for travis"
	@brew install elixir
	@mix local.hex --force
	@mix local.rebar --force

travis-linux: travis-docker-centos travis-docker-ubuntu

travis-darwin: darwin-builds darwin

travis-deploy: release

all-centos: dep build centos
all-ubuntu: dep build ubuntu

travis-docker-centos:
	docker pull tchen/centos-elixir && docker run -v $(PWD):/mnt/deps --rm -it tchen/centos-elixir /bin/bash -c "cd /mnt/deps && make centos-builds && make all-centos"

travis-docker-ubuntu:
	docker pull tchen/ubuntu-elixir && docker run -v $(PWD):/mnt/deps --rm -it tchen/ubuntu-elixir /bin/bash -c "cd /mnt/deps && make centos-builds && rm -rf src/deps; make all-ubuntu"



include .makefiles/*.mk

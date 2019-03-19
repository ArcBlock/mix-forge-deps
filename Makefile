TOP_DIR=.
VERSION=$(strip $(shell cat version))

dep:
	@echo "Install dependencies required for this repo..."
	@cd src; mix deps.get

build:
	@echo "Building the software..."
	@cd src; mix compile

travis-init:
	@echo "Initialize software required for travis"

travis: travis-docker-ubuntu travis-docker-centos

travis-deploy: release

all-centos: dep build build-centos
all-ubuntu: dep build build-ubuntu

travis-docker-centos:
	docker pull tchen/centos-elixir && docker run -v $(PWD):/mnt/deps --rm -it tchen/centos-elixir /bin/bash -c "cd /mnt/deps && make extract-centos && make all-centos"

travis-docker-ubuntu:
	docker pull tchen/ubuntu-elixir && docker run -v $(PWD):/mnt/deps --rm -it tchen/ubuntu-elixir /bin/bash -c "cd /mnt/deps && make extract-ubuntu && make all-ubuntu"



include .makefiles/*.mk

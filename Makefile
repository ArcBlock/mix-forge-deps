TOP_DIR=.
VERSION=$(strip $(shell cat version))

dep:
	@echo "Install dependencies required for this repo..."
	@cd src; mix deps.get

build:
	@echo "Building the software..."
	@cd src; mix compile

travis-init: get-deps
	@echo "Initialize software required for travis (normally ubuntu software)"

travis: travis-docker-ubuntu travis-docker-centos release

all: dep build build-release

travis-docker-centos:
	docker run -v $(PWD):/mnt/deps --rm -it tchen/centos-elixir /bin/bash -c "cd /mnt/deps && make extract-centos && make all"

travis-docker-ubuntu:
	docker run -v $(PWD):/mnt/deps --rm -it tchen/centos-elixir /bin/bash -c "cd /mnt/deps && make extract-ubuntu && make all"



include .makefiles/*.mk

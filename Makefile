TOP_DIR=.
VERSION=$(strip $(shell cat version))

dep:
	@echo "Install dependencies required for this repo..."
	@cd src; mix deps.get

build:
	@echo "Building the software..."
	@cd src; mix compile

travis-init:
	@echo "Initialize software required for travis (normally ubuntu software)"

travis: dep build

travis-deploy: build-release release
	@echo "Deploy the software by travis"

include .makefiles/*.mk

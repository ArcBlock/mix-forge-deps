SRC=src
BUILD_VERSION=v$(VERSION)
RELEASE_DIR=$(SRC)/_build/releases

build-all:
	@echo "Building all dependencies..."
	@cd $(SRC); mix deps.get
	@echo "Building dependencies for MIX_ENV=prod..."
	@cd $(SRC); MIX_ENV=prod mix compile
	@echo "Building dependencies for MIX_ENV=staging..."
	@cd $(SRC); MIX_ENV=staging mix compile
	@echo "Building dependencies for MIX_ENV=dev..."
	@cd $(SRC); MIX_ENV=dev mix compile
	@echo "Building dependencies for MIX_ENV=test..."
	@cd $(SRC); MIX_ENV=test mix compile
	@cd $(SRC); tar zcf builds.tgz _build/ deps/

build-ubuntu: build-all
	mv $(SRC)/builds.tgz $(SRC)/ubuntu-builds.tgz

build-centos: build-all
	mv $(SRC)/builds.tgz $(SRC)/centos-builds.tgz

build-version-file:
	@echo "$(BUILD_VERSION)" > $(RELEASE_DIR)/$(BUILD_VERSION)
	@mv $(SRC)/*.tgz $(RELEASE_DIR)

$(RELEASE_DIR):
	@mkdir -p $@

build-release: $(RELEASE_DIR) build-all build-version-file

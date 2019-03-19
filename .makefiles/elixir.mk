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
	@cd $(SRC); tar zcf builds.tgz _build/prod _build/staging _build/dev _build/test deps/

build-ubuntu: $(RELEASE_DIR) build-all build-version-file
	@mv $(SRC)/builds.tgz $(RELEASE_DIR)/ubuntu-builds.tgz

build-centos: $(RELEASE_DIR) build-all build-version-file
	mv $(SRC)/builds.tgz $(RELEASE_DIR)/centos-builds.tgz

build-version-file:
	@echo "$(BUILD_VERSION)" > $(RELEASE_DIR)/$(BUILD_VERSION)


$(RELEASE_DIR):
	@mkdir -p $@

SRC=src
BUILD_VERSION=v$(VERSION)
RELEASE_DIR=$(SRC)/_build/releases
TARGETS=centos ubuntu darwin

build-all:
	@echo "Building dependencies for MIX_ENV=staging..."
	@cd $(SRC); MIX_ENV=staging mix compile
	@echo "Building dependencies for MIX_ENV=dev..."
	@cd $(SRC); MIX_ENV=dev mix compile
	@echo "Building dependencies for MIX_ENV=test..."
	@cd $(SRC); MIX_ENV=test mix compile
	@echo "Tar everything up..."
	@cd $(SRC); tar zcf builds.tgz _build/staging _build/dev _build/test deps/

$(TARGETS): $(RELEASE_DIR) build-all build-version-file
	@mv $(SRC)/builds.tgz $(RELEASE_DIR)/$@-builds.tgz

build-version-file:
	@echo "$(BUILD_VERSION)" > $(RELEASE_DIR)/$(BUILD_VERSION)

$(RELEASE_DIR):
	@mkdir -p $@

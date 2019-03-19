SRC=src
DEPS_VER=v0.6.0
DEPS_PREFIX=https://github.com/ArcBlock/mix-forge-deps/releases/download
CENTOS=centos-builds.tgz
UBUNTU=ubuntu-builds.tgz
BUILDS_URL=$(DEPS_PREFIX)/$(DEPS_VER)

get-deps:
	@echo "Extracting deps from mix-forge-deps repo $(DEPS_VER)..."
	@cd $(SRC); wget $(BUILDS_URL)/$(CENTOS) --quiet; wget $(BUILDS_URL)/$(UBUNTU) --quiet; true

extract-centos:
	@cd $(SRC); rm -rf _build/{dev,staging,test,prod}; rm -rf deps; tar zxf $(CENTOS); true

extract-ubuntu:
	@cd $(SRC); rm -rf _build/{dev,staging,test,prod}; rm -rf deps; tar zxf $(UBUNTU); true

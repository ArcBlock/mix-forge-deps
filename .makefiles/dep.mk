SRC=src
DEPS_VER=v0.6.1
DEPS_PREFIX=https://github.com/ArcBlock/mix-forge-deps/releases/download
CENTOS=centos-builds.tgz
UBUNTU=ubuntu-builds.tgz
BUILDS_URL=$(DEPS_PREFIX)/$(DEPS_VER)

extract-centos:
	@cd $(SRC); wget $(BUILDS_URL)/$(CENTOS) --quiet; rm -rf _build/{dev,staging,test,prod}; rm -rf deps; tar zxf $(CENTOS); rm *.tgz

extract-ubuntu:
	@cd $(SRC); wget $(BUILDS_URL)/$(UBUNTU) --quiet; rm -rf _build/{dev,staging,test,prod};  rm -rf deps; tar zxf $(UBUNTU); rm *.tgz

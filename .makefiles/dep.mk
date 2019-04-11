SRC=src
DEPS_VER=v0.8.0
DEPS_PREFIX=https://github.com/ArcBlock/mix-forge-deps/releases/download
TARGETS=centos-builds ubuntu-builds darwin-builds
BUILDS_URL=$(DEPS_PREFIX)/$(DEPS_VER)



$(TARGETS):
	@cd $(SRC); wget $(BUILDS_URL)/$@.tgz --quiet; rm -rf _build/{dev,staging,test,prod}; rm -rf deps; tar zxf $@.tgz; rm *.tgz

SRC=src
DEPS_VER=v0.8.7
DEPS_PREFIX=https://github.com/ArcBlock/mix-forge-deps/releases/download
TARGETS=centos-builds ubuntu-builds darwin-builds

$(TARGETS):
	@echo "Extracting $@ deps from mix-forge-deps repo $(DEPS_VER)..."
	@cd $(SRC); wget --quite $(DEPS_PREFIX)/$(DEPS_VER)/$@.tgz; rm -rf _build/{staging,dev,test} deps; tar zxf $@.tgz; rm *.tgz || true

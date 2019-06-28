VERSION=$(strip $(shell cat version))

export ERLANG_ROCKSDB_OPTS=-DWITH_ZSTD=ON

dep:
	@echo "Install dependencies required for this repo..."
	@cd src; mix deps.get

# ------------------------------------------------------------------
# travis linux (centos/ubuntu)
# ------------------------------------------------------------------

travis-linux-init:
	@echo "Initialize software required for travis"

travis-centos-fix-dep:
	@rm -f /usr/lib64/libgmp.so /usr/lib64/libgmp.a                         # use static link for libsecp256k1/gmp
	@cp /mnt/home/src/priv/centos_libgmp.a /usr/lib64/libgmp.a
	@rm -f /usr/local/lib/libzstd.so /usr/local/lib/libzstd.a               # use static link for rocksdb/zstd
	@cp /mnt/home/src/priv/centos_libzstd.a /usr/local/lib/libzstd.a

travis-linux: travis-docker-centos

all-centos: dep centos

travis-docker-centos:
	@docker pull tchen/centos-elixir:1.9 && docker run -v $(PWD):/mnt/home --rm -it tchen/centos-elixir /bin/bash -c "cd /mnt/home && make centos-builds && make travis-centos-fix-dep && make all-centos"

# ------------------------------------------------------------------
# travis darwin
# ------------------------------------------------------------------

travis-darwin-init:
	@echo "Initialize software required for travis darwin"
	@HOMEBREW_NO_AUTO_UPDATE=1 brew install https://raw.githubusercontent.com/Homebrew/homebrew-core/20fe974089abdb0f324dab2277658f82eaaac87a/Formula/erlang.rb --ignore-dependencies # erlang 22.0.4
	@HOMEBREW_NO_AUTO_UPDATE=1 brew install https://raw.githubusercontent.com/Homebrew/homebrew-core/bacd78012c1023819dddc312ca35938914527290/Formula/elixir.rb --ignore-dependencies # elixir 1.9.0
	@mix local.hex --force
	@mix local.rebar --force

travis-darwin-fix-dep:
	@rm /usr/local/lib/libgmp.dylib      # use static link for libsecp256k1/gmp
	@rm /usr/local/lib/libzstd.dylib     # use static link for rocksdb/zstd

travis-darwin: darwin-builds travis-darwin-fix-dep dep darwin

# ------------------------------------------------------------------
# travis deploy
# ------------------------------------------------------------------

travis-deploy: release

include .makefiles/*.mk

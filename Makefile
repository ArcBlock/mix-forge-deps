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
	@docker pull tchen/centos-elixir:1.9.1 && docker run -v $(PWD):/mnt/home --rm -it tchen/centos-elixir:1.9.1 /bin/bash -c "cd /mnt/home && make centos-builds && make travis-centos-fix-dep && make all-centos"

# ------------------------------------------------------------------
# travis darwin
# ------------------------------------------------------------------

travis-darwin-init:
	@echo "Initialize software required for travis darwin"
	@HOMEBREW_NO_AUTO_UPDATE=1 brew install https://raw.githubusercontent.com/Homebrew/homebrew-core/d17df4af5f224ddc2aa56502b0fe75f3f7d253ce/Formula/erlang.rb --ignore-dependencies # erlang 22.0.7
	@HOMEBREW_NO_AUTO_UPDATE=1 brew install https://raw.githubusercontent.com/Homebrew/homebrew-core/a6de24ba2fa7ce9ccd8a903a6422bf733a415866/Formula/elixir.rb --ignore-dependencies # elixir 1.9.1
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

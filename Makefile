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

# travis-linux: travis-docker-centos travis-docker-ubuntu

travis-linux: travis-docker-centos

all-centos: dep centos

all-ubuntu: dep ubuntu

travis-docker-centos:
	@docker pull tchen/centos-elixir && docker run -v $(PWD):/mnt/deps --rm -it tchen/centos-elixir /bin/bash -c "cd /mnt/deps && make centos-builds && make all-centos"

travis-docker-ubuntu:
	@docker pull tchen/ubuntu-elixir && docker run -v $(PWD):/mnt/deps --rm -it tchen/ubuntu-elixir /bin/bash -c "cd /mnt/deps && make centos-builds && make all-ubuntu"

# ------------------------------------------------------------------
# travis darwin
# ------------------------------------------------------------------

travis-darwin-init:
	@echo "Initialize software required for travis darwin"
	@HOMEBREW_NO_AUTO_UPDATE=1 brew install https://raw.githubusercontent.com/Homebrew/homebrew-core/438814082094bdac172648b5efa03f2596d46f38/Formula/erlang.rb --ignore-dependencies # erlang 21.3.5
	@HOMEBREW_NO_AUTO_UPDATE=1 brew install https://raw.githubusercontent.com/Homebrew/homebrew-core/c19ee54756997f56ea407d0817a8c33213b2e10b/Formula/elixir.rb --ignore-dependencies # elixir 1.8.1
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

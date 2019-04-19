ARG ELIXIR_VER=1.8.0
FROM elixir:$ELIXIR_VER-alpine
RUN apk update && \
  apk upgrade --no-cache && \
  apk add --no-cache \
  wget libbz2 libtool openssl-dev unzip binutils zlib  libstdc++ make cmake git g++ \
  autoconf bzip2-dev automake linux-headers  gmp-dev  python sqlite-dev
COPY .  .
RUN mix local.hex --force && mix local.rebar --force 
WORKDIR /src
RUN mix deps.get && MIX_ENV=staging mix compile 

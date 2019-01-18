FROM elixir:1.7.2-alpine
RUN apk update && \
  apk upgrade --no-cache && \
  apk add --no-cache \
  wget libbz2 libtool openssl-dev unzip binutils zlib  libstdc++ make cmake git g++ \
  autoconf bzip2-dev automake linux-headers  gmp-dev  python
COPY .  .
RUN mix local.hex --force && mix local.rebar --force 
WORKDIR /src
RUN mix deps.get && MIX_ENV=staging mix compile




FROM tchen/centos-elixir

RUN yum install -y -q cmake3 gcc-c++

COPY .  .

RUN make dep && make build && make build-release

# Remove SSH keys
RUN rm -rf /root/.ssh/


CMD ["/bin/sh"]

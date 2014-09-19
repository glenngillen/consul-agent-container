FROM ubuntu:trusty
MAINTAINER Glenn Gillen <me@glenngillen.com>

RUN apt-get update && apt-get install -y iptables curl unzip

ADD https://dl.bintray.com/mitchellh/consul/0.4.0_linux_amd64.zip /tmp/consul.zip
RUN cd /bin && unzip /tmp/consul.zip && chmod +x /bin/consul && rm /tmp/consul.zip

ADD ./config /config/
ADD ./start /bin/start

ENV SERVICE_53_NAME consul-dns
ENV SERVICE_18500_NAME consul-http
ENV SERVICE_18400_NAME consul-rpc
ENV SERVICE_18300_NAME consul-server
ENV SERVICE_18301_NAME serf-lan
ENV SERVICE_18302_NAME serf-wan
ENV DOCKER_HOST unix:///tmp/docker.sock

EXPOSE 8300 8301 8301/udp 8302 8302/udp 8400 8500 53/udp
VOLUME ["/data"]

ENTRYPOINT ["/bin/start"]
CMD []

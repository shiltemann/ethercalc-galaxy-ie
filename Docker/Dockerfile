FROM ubuntu

MAINTAINER Saskia Hiltemann <zazkia@gmail.com>

USER root

ENV DEBIAN_FRONTEND=noninteractive \
    DEBUG=false \
    GALAXY_WEB_PORT=10000 \
    NOTEBOOK_PASSWORD=none \
    CORS_ORIGIN=none \
    DOCKER_PORT=none \
    API_KEY=none \
    HISTORY_ID=none \
    REMOTE_HOST=none \
    GALAXY_URL=none

# install node.js
# RUN add-apt-repository ppa:chris-lea/node.js
# RUN echo "deb http://us.archive.ubuntu.com/ubuntu/ precise universe" >> /etc/apt/sources.list
RUN apt-get update && \
    apt-get install -y apt-utils && \
    apt-get install -y python-software-properties git python g++ make libssl-dev pkg-config build-essential redis-server && \
    apt-get install -y curl nodejs npm nginx net-tools procps

# install ethercalc
RUN (cd /opt && \
     git clone https://github.com/audreyt/ethercalc.git ethercalc && \
     cd ethercalc && \
     npm install)

ADD ./start.html /opt/ethercalc/start.html

# GIE setup
ADD ./startup.sh /startup.sh
ADD ./monitor_traffic.sh /monitor_traffic.sh
ADD ./proxy.conf /proxy.conf

RUN mkdir -p /import /run/nginx

VOLUME ["/import"]
WORKDIR /import/

EXPOSE 80 6379 6967

CMD /startup.sh

FROM ubuntu:trusty
MAINTAINER Tim Haak <tim@haak.co.uk>
#Thanks to https://github.com/bydavy/docker-plex/blob/master/Dockerfile and https://github.com/aostanin/docker-plex/blob/master/Dockerfile

ENV DEBIAN_FRONTEND="noninteractive" \
    LANG="en_US.UTF-8" \
    LC_ALL="C.UTF-8" \
    LANGUAGE="en_US.UTF-8" \
    PLEX_VERSION="0.9.12.8.1362-4601e39"

RUN apt-get -q update && \
    apt-get install -qy --force-yes curl && \
    curl -o /tmp/plexmediaserver_${PLEX_VERSION}_amd64.deb "https://downloads.plex.tv/plex-media-server/${PLEX_VERSION}/plexmediaserver_${PLEX_VERSION}_amd64.deb" && \
    apt-get -q update && \
    apt-get -qy --force-yes dist-upgrade && \
    apt-get install -qy --force-yes supervisor ca-certificates procps && \
    dpkg -i /tmp/plexmediaserver_${PLEX_VERSION}_amd64.deb && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /tmp/*

VOLUME ["/config","/data"]

ADD ./start.sh /start.sh
RUN chmod u+x  /start.sh

EXPOSE 32400

CMD ["/start.sh"]

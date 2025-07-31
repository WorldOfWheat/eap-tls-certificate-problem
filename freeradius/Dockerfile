FROM freeradius/freeradius-server:3.2.7-alpine
MAINTAINER WorldOfWheat

RUN mkdir -p /etc/ssl
ADD secrets/* /etc/ssl
COPY secrets/raddb/ /etc/raddb/

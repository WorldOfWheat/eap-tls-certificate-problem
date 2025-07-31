FROM ubuntu:jammy-20250714
MAINTAINER WorldOfWheat

RUN mkdir strongswan-build
WORKDIR strongswan-build
RUN apt update -y
RUN apt upgrade -y
RUN apt install -y wget bzip2 build-essential iptables vim systemd

# RUN apt install -y strongswan libstrongswan-extra-plugins strongswan-swanctl
RUN wget https://download.strongswan.org/strongswan-6.0.2.tar.bz2
RUN bzip2 -d strongswan-6.0.2.tar.bz2
RUN tar xvf strongswan-6.0.2.tar
WORKDIR strongswan-6.0.2
RUN apt install -y libssl-dev pkg-config libsystemd-dev
RUN ./configure --prefix=/usr --sysconfdir=/etc --enable-silent-rules --enable-charon --enable-systemd --enable-ikev2 --enable-vici --enable-swanctl --enable-nonce --enable-random --enable-drbg --enable-openssl --enable-pem --enable-x509 --enable-constraints --enable-revocation --enable-pki --enable-pubkey --enable-socket-default --enable-kernel-netlink --enable-resolve --enable-eap-identity --enable-eap-radius --enable-eap-dynamic --enable-eap-tls --enable-updown --with-systemdsystemunitdir=/lib/systemd/system --with-systemduserunitdir=/usr/lib/systemd --enable-radattr
RUN make
RUN make install

WORKDIR /
COPY secrets/IPSec_cert/ca_cert.pem /etc/swanctl/x509ca/ca.pem
COPY secrets/IPSec_cert/server_cert.pem /etc/swanctl/x509/pub.pem
COPY secrets/IPSec_cert/server_priv.pem /etc/swanctl/private/priv.pem

COPY secrets/swanctl.conf /etc/swanctl
COPY secrets/strongswan.conf /etc/strongswan.conf

ADD secrets/docker-entrypoint.sh /docker-entrypoint.sh
RUN chmod a+x /docker-entrypoint.sh


RUN echo "net.ipv4.ip_forward=1" >> /etc/sysctl.conf

ENTRYPOINT ["/docker-entrypoint.sh"]
# ENTRYPOINT ["tail", "-f", "/dev/null"]

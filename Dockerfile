#ver-2021.01.02.16.30
###############################################################################
# BUILD STAGE
FROM alpine:edge as builder
MAINTAINER niiv0832 <dockerhubme-sslibev@yahoo.com
##
ARG SSRUST_VER=1.8.23
##
RUN set -ex && \
    mkdir -p /tmp/ss && \
    apk add --no-cache --update wget tar xz && \
    rm -rf /var/cache/apk/* && \
    mkdir -p /etc/ss/cfg && \
    cd /tmp/ss && \
    wget --no-check-certificate https://github.com/shadowsocks/shadowsocks-rust/releases/download/v1.8.23/shadowsocks-v1.8.23.x86_64-unknown-linux-musl.tar.xz -P /tmp/ss && \
    tar -xvf /tmp/ss/shadowsocks-v1.8.23.x86_64-unknown-linux-musl.tar.xz
RUN mv /tmp/ss/ssserver /ssserver
RUN apk del wget tar libacl libunistring libidn2
RUN rm -rf /var/cache/apk/*
RUN rm -rf /tmp/ss
#    
###############################################################################
# PACKAGE STAGE          
FROM scratch
MAINTAINER niiv0832 <dockerhubme-sslibev@yahoo.com
COPY --from=builder /ssserver /ssserver
##                       
VOLUME ["/etc/ss/cfg/"]
##
EXPOSE 7500
##
ENTRYPOINT ["/ssserver"]
##
CMD ["-u", "-c", "/etc/ss/cfg/shadowsocks_rust.json"]

#ver-2021.04.15.12.37
###############################################################################
# BUILD STAGE
FROM alpine:edge as builder
MAINTAINER niiv0832 <dockerhubme-sslibev@yahoo.com
##
ARG SSRUST_VER=1.10.5
##
RUN set -ex && \
    mkdir -p /tmp/ss && \
    apk add --no-cache --update wget tar xz && \
    rm -rf /var/cache/apk/* && \
    mkdir -p /etc/ss/cfg && \
    cd /tmp/ss && \
    wget --no-check-certificate https://github.com/shadowsocks/shadowsocks-rust/releases/download/v${SSRUST_VER}/shadowsocks-v${SSRUST_VER}.x86_64-unknown-linux-musl.tar.xz -P /tmp/ss && \
    tar -xvf /tmp/ss/shadowsocks-v${SSRUST_VER}.x86_64-unknown-linux-musl.tar.xz && \
    mv /tmp/ss/ssserver /ssserver && \
    apk del wget tar libacl libunistring libidn2 && \
    rm -rf /var/cache/apk/* && \
    rm -rf /tmp/ss
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
##CMD ["-u", "--config", "/etc/ss/cfg/shadowsocks_rust.json"]
CMD ["-u --config /etc/ss/cfg/shadowsocks_rust.json"]

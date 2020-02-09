#ver-2020.02.09.20.59
###############################################################################
# BUILD STAGE
FROM alpine:edge as builder
MAINTAINER niiv0832 <dockerhubme-sslibev@yahoo.com
##
ARG SSRUST_VER=1.8.8
##
RUN set -ex && \
     mkdir -p /tmp/ss && \
     apk add --no-cache --update wget tar && \
     rm -rf /var/cache/apk/* && \
     mkdir -p /etc/ss/cfg && \
     cd /tmp/ss && \
     wget -q --no-check-certificate https://github.com/shadowsocks/shadowsocks-rust/releases/download/v${SSRUST_VER}/shadowsocks-v${SSRUST_VER}-stable.x86_64-unknown-linux-musl.tar.xz && \ 
     tar -xvf shadowsocks-v${SSRUST_VER}-stable.x86_64-unknown-linux-musl.tar.xz  && \
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
CMD ["-u", "-c", "/etc/ss/cfg/shadowsocks_rust.json"]

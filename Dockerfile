FROM alpine:edge
MAINTAINER niiv0832 <dockerhubme-sslibev@yahoo.com
##
ARG SSRUST_VER=1.8.7
##
RUN set -ex && \
     mkdir -p /tmp/ss && \
     apk add --no-cache --update wget && \
     rm -rf /var/cache/apk/* && \
     mkdir -p /etc/ss/cfg && \
     cd /tmp/ss && \
     wget -q --no-check-certificate https://github.com/shadowsocks/shadowsocks-rust/releases/download/v${SSRUST_VER}/shadowsocks-v${SSRUST_VER}-stable.x86_64-unknown-linux-musl.tar.xz && \ 
     tar -xzf /tmp/ss/shadowsocks-v${SSRUST_VER}-stable.x86_64-unknown-linux-musl.tar.xz  && \
     mv /tmp/ss/ssserver /ssserver && \
     apt del wget && \
     rm -rf /var/cache/apk/* && \
     rm -rf /tmp/ss
##                       
VOLUME ["/etc/ss/cfg/"]
##
EXPOSE 7500
##
USER nobody
##
ENTRYPOINT ["/ssserver"]
##
CMD ["--config", "/cfg/shadowsocks_rust.json", "-u"]

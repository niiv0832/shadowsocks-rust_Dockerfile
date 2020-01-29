###############################################################################
# BUILD STAGE
FROM rust:buster

RUN set -x && \
                apt install -y bash && \
                cargo install shadowsocks-rust
EXPOSE 55555
VOLUME ["/cfg"]   
ENTRYPOINT ["ssserver"]
###############################################################################
# PACKAGE STAGE

#FROM scratch

#COPY --from=0 /usr/local/bin/ssserver /ssserver

#VOLUME ["/cfg"]

#EXPOSE 55555

#ENTRYPOINT ["/ssserver"]

#CMD ["-config", "/cfg/shadowsocks_o.yml", "--replay_history", "1000"]

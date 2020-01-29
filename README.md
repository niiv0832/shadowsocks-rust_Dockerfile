# Docker container for fast proxy setup based on Shadowsocks-rust proxy

Shadowsocks-rust Server (`udp`) running from config file

```shell
docker run -d --name=ssrustserv --restart=always -v $YOUR_PATH_TO_JSON_CONFIG_DIR$:/etc/ssr/cfg -p $YOUR_PORT$:7500 -t niiv0832/shadowsocks_rust
```

In config must be port `7500`. Config file name must be `"shadowsocks_r.json"`

## Links:
Link on docker hub: <a href="https://hub.docker.com/r/niiv0832/shadowsocks_rust">niiv0832/shadowsocks_rust</a>

Link on github: <a href="https://www.github.com/niiv0832/shadowsocks-rust_Dockerfile">niiv0832/Shadowsocks-rust</a>

#!/bin/bash
docker build --rm -t pickapp/mariadb-alpine:10.1.19-r0 .
# docker build --rm --no-cache -t pickapp/hma-proxy:1.2 .
# docker push pickapp/hma-proxy:1.2

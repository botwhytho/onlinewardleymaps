#!/usr/bin/env bash

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
docker build -t onlinewardleymaps:local "${SCRIPT_DIR}"
docker run --rm -it -p 127.0.0.1:3000:3000 -e "ALLOWED_CIDR=$(docker network inspect bridge | jq -r '.[0].IPAM.Config[0].Subnet')" --cap-add=NET_ADMIN  --name wardleymaps onlinewardleymaps:local yarn start

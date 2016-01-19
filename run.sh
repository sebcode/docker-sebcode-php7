#!/usr/bin/env bash

set -e

echo https://$(docker-machine ip default):3000/

set -x
docker run -it -p 3000:443 sebcode/php7


#!/usr/bin/env bash

set -e

set -x
docker run -it -p 3000:443 sebcode/php7 bash


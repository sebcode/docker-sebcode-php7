#!/usr/bin/env bash

set -e
set -x

openssl req -x509 -newkey rsa:2048 -keyout tmpcert.key -out tmpcert.pem -days 30 \
  -subj "/C=DE/ST=NRW/L=X/O=Company Name/OU=Org/CN=www.example.com" \
  -nodes


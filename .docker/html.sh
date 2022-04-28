#!/bin/sh

pandoc -s -N --metadata-file=content/meta.yml --toc \
    --variable "geometry=margin=1in" \
    content/*/README.md \
    -o intro-dev-web.html

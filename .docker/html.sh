#!/bin/sh

pandoc -s --metadata-file=content/meta.yml --toc \
    --shift-heading-level-by=1 \
    --variable "geometry=margin=1in" \
    content/*/README.md \
    -o intro-dev-web.html

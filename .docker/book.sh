#!/bin/sh

pandoc -s -N --variable "geometry=margin=1in" \
    --metadata-file=content/meta.yml \
    content/1_introducao/README.md \
    content/2_algoritmos/README.md \
    content/3_git/README.md \
    content/4_react/README.md \
    content/5_lumen/README.md \
    --toc -o intro-dev-web.pdf

pandoc -s -N --variable "geometry=margin=1in" \
    --metadata-file=content/meta.yml \
    content/1_introducao/README.md \
    content/2_algoritmos/README.md \
    content/3_git/README.md \
    content/4_react/README.md \
    content/5_lumen/README.md \
    --toc -o intro-dev-web.epub

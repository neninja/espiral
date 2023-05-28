#!/bin/sh

for pathLivro in content/livro*; do
    pathCapitulosLivro="$pathLivro/*/README.md"
    nomeLivro=${pathLivro##*/}
    pandoc -s -N --metadata-file=content/meta.yml --toc \
        --variable "geometry=margin=1in" \
        $pathCapitulosLivro \
        -o build/$nomeLivro.html
done

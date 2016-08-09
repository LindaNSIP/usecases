#!/bin/sh

pandoc $1 -o $2 --template ../sample/pandoc/standalone.html --toc --toc-depth=2 --filter pandoc-include

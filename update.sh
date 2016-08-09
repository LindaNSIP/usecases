#!/bin/sh

# Optional - "git checkout ." - to cleanup
git pull

# $PWD = `pwd`

pandoc sample/pandoc/test.md -o sample/pandoc/test.html --template sample/pandoc/standalone.html --toc --toc-depth=2 --filter pandoc-include

pandoc sample/pandoc/daily_attendance.md -o sample/pandoc/daily_attendance.html --template sample/pandoc/standalone.html --toc --toc-depth=2 --filter pandoc-include


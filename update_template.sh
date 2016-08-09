#!/bin/sh
pandoc convert/$1 -o ../hits-dashboard/right/dist/$2 --template ../hits-dashboard/right/dist/template.html --toc --toc-depth=2

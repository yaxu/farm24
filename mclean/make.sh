#!/bin/bash

#cabal run
#perl -pi -w -e 's/<svg\s+(.*?)>/<svg $1 shape-rendering="crispEdges">/' figures/*svg

#for file in figures/*.svg; do
#  inkscape --file=$file --without-gui --export-pdf="${file%.svg}.pdf"
#done

#sed 's/haskell \(ignore\|top\)/haskell/g' src/icfp.md > tmp/icfp.md
pandoc --mathjax --citeproc farm24.md -o farm24.tex
pdflatex template.tex
mv template.pdf farm24.pdf

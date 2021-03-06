#!/bin/bash

rm -rf build

if [ ! -d chibi-scheme ] ; then
  hg clone  https://code.google.com/p/chibi-scheme/ chibi-scheme;
fi

cd chibi-scheme
hg pull
hg update

make dist
cp chibi-scheme-`cat VERSION`.tgz ../chibi-scheme.tgz

make chibi-scheme-static PLATFORM=emscripten SEXP_USE_DL=0


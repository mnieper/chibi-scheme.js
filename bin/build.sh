#!/bin/bash

if [ ! -d build ] ; then
  mkdir build
  tar xzf chibi-scheme.tgz -C build --strip-components=1
fi

cd build

emmake make PLATFORM=emscripten CHIBI_DEPENDENCIES= CHIBI=../chibi-scheme/chibi-scheme-static PREFIX= CFLAGS=-O2 SEXP_USE_DL=0 EXE=.bc SO=.bc CPPFLAGS="-DSEXP_USE_STRICT_TOPLEVEL_BINDINGS=1 -DSEXP_USE_ALIGNED_BYTECODE=1 -DSEXP_USE_STATIC_LIBS=1" c-libs clibs.c chibi-scheme-static.bc

emcc -O2 chibi-scheme-static.bc -o ../chibi.js -s MODULARIZE=1 -s EXPORT_NAME=\"Chibi\" -s EXPORTED_FUNCTIONS=@$PWD/../exported_functions.json `find  lib -type f \( -name "*.scm" -or -name "*.sld" \) -printf " --preload-file %p"` --pre-js ../pre.js --post-js ../post.js 


#!/usr/bin/env bash

set -euo pipefail

OPT_MODE=${1:-n}

mkdir -p public
cp -r static/* public

# Main
PROG=Main

echo "Building $PROG..."
elm make src/Main.elm --optimize --output public/$PROG.js
if [ $OPT_MODE = "-O" ]; then
  echo "Optimising..."
  uglifyjs public/$PROG.js --compress "pure_funcs=[F2,F3,F4,F5,F6,F7,F8,F9,A2,A3,A4,A5,A6,A7,A8,A9],pure_getters,keep_fargs=false,unsafe_comps,unsafe" | uglifyjs --mangle -o public/$PROG.min.js
else
  echo "Not optimising."
  mv public/$PROG.js public/$PROG.min.js
fi

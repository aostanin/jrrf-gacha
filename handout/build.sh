#!/usr/bin/env bash
# Build the festival handouts. Expects to run inside `nix develop` from the
# repo root, which supplies typst, openscad, imagemagick, qrencode and the
# typst font path.

set -euo pipefail
cd "$(dirname "$0")"

repo_url="https://github.com/aostanin/jrrf-gacha"

echo "→ _assets/github-qr.svg"
qrencode -o _assets/github-qr.svg -t SVG -s 8 -m 1 "$repo_url"

echo "→ _assets/exploded.png"
tmp=$(mktemp -d)
trap 'rm -rf "$tmp"' EXIT

openscad \
  --render \
  --colorscheme="Tomorrow" \
  --imgsize=2000,3200 \
  --projection=ortho \
  --autocenter --viewall \
  --camera=0,0,0,55,0,25,0 \
  -o "$tmp/exploded.raw.png" \
  ../model/exploded.scad

magick "$tmp/exploded.raw.png" \
  -fuzz 6% -fill white -opaque white \
  -trim +repage \
  -bordercolor white -border 280x180 \
  _assets/exploded.png

for src in explanation-en.typ explanation-ja.typ; do
  out="${src%.typ}.pdf"
  echo "→ $out"
  typst compile --root .. "$src" "$out"
done

echo "Done."

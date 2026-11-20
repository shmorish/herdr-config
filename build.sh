#!/bin/sh
# mods/*/main.ts を main.js に変換し、mod のフォルダごと $1 に置く（Herdr が読むのは main.js だけ）。
# import はそのまま残す（gpui-kit や herdr は Herdr が実行時に渡す）。
set -eu
out=$1
mkdir -p "$out"
for d in mods/*/; do
  name=$(basename "$d")
  rm -rf "${out:?}/$name"
  mkdir -p "$out/$name"
  for f in "$d"*; do
    case "$f" in *.ts) ;; *) cp "$f" "$out/$name/" ;; esac
  done
  esbuild "$d/main.ts" --outfile="$out/$name/main.js" --format=esm --target=es2022 --log-level=warning
done

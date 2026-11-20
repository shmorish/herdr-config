#!/bin/sh
# mods/*/main.ts を esbuild でまとめて main.js にし、mod のフォルダごと $1 に置く（Herdr が読むのは main.js だけ）。
# lib/ などの相対 import は main.js に取り込み、gpui-kit や herdr のような名前だけの import は
# Herdr が実行時に渡すのでそのまま残す（--packages=external）。
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
  esbuild "$d/main.ts" --bundle --packages=external --format=esm --target=es2022 --charset=utf8 --outfile="$out/$name/main.js" --log-level=warning
done

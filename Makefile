NIX_TSC = nix shell nixpkgs\#typescript --command tsc
NIX_ESBUILD = nix shell nixpkgs\#esbuild --command

.PHONY: check build dev types

# 型チェック
check:
	$(NIX_TSC) -p .

# dist/mods に変換結果を置く
build:
	$(NIX_ESBUILD) ./build.sh dist/mods

# 手元の Herdr に直接置いて試す（次の make switch で dotfiles の固定版に戻る）
dev:
	$(NIX_ESBUILD) ./build.sh $(HOME)/.config/herdr-app/mods

# Herdr を更新したあと、型定義を取り直す
types:
	cp $(HOME)/.config/herdr-app/herdr.d.ts $(HOME)/.config/herdr-app/gpui-kit.d.ts types/

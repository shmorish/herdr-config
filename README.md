# herdr-config

Herdr.app（`~/.config/herdr-app`）の自作の設定・mod・レイアウト。

| パス | 中身 |
|---|---|
| `settings.json`, `keys.json` | アプリの設定とキー割り当て |
| `layouts/work.json` | 普段使うレイアウト（Ocean 配色のガラス風） |
| `mods/` | 自作 mod（projects / work-agents / work-tabs / board / claude-limits） |
| `themes/` | 取り込んだテーマ（rose-pine、MIT） |

## 入れ方

[dotfiles](https://github.com/shmorish/dotfiles) の Home Manager がコミット固定で取ってきて、`~/.config/herdr-app` に実ファイルとしてコピーする。
変えたらここにコミット・push し、dotfiles の `herdrConfig` の rev と hash を上げて `make switch`。

コミュニティの mod（Moe Office の fork、Herdr Glass）は dotfiles 側で取ってくる。

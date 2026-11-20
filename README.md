# herdr-config

Herdr.app（`~/.config/herdr-app`）の自作の設定・mod・レイアウト。

| パス | 中身 |
|---|---|
| `settings.json`, `keys.json` | アプリの設定とキー割り当て |
| `layouts/work.json` | 普段使うレイアウト（Ocean 配色のガラス風、Office はナチュラルな部屋） |
| `mods/` | 自作 mod（projects / work-agents / work-tabs / board / claude-limits）。TypeScript |
| `types/` | Herdr の型定義の写し（Apache-2.0） |
| `themes/` | 取り込んだテーマ（rose-pine、MIT） |

## 開発

mod は `mods/<mod>/main.ts` に TypeScript で書く。Herdr が読むのは `main.js` だけなので、esbuild で変換して使う。

- `make check`: 型チェック（`strict`、null チェックあり）
- `make dev`: 変換して `~/.config/herdr-app/mods` に置き、手元の Herdr で試す（レイアウトを切り替え直すと読み込まれる）
- `make types`: Herdr を更新したあと、型定義を取り直す

CI でも型チェックと変換を確かめる。

## 入れ方

[dotfiles](https://github.com/shmorish/dotfiles) の Home Manager がコミット固定で取ってきて、`build.sh` で変換したものを `~/.config/herdr-app` に実ファイルとしてコピーする。
変えたらここにコミット・push し、dotfiles の `herdrConfig` の rev と hash を上げて `make switch`。

コミュニティの mod（Office: Moe Office の fork、Herdr Glass）は dotfiles 側で取ってくる。

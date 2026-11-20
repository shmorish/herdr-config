# herdr-config

[Herdr.app](https://herdr.dev)（`~/.config/herdr-app`）の自分用の設定、レイアウト、mod。複数の repo をまとめた「案件」フォルダで、Claude Code の agent を何人も並べて動かすための作りにしている。

## 中身

| パス | 中身 |
|---|---|
| `settings.json` | フォント、ダーク表示、テーマ（ダークは rose-pine） |
| `keys.json` | キー割り当て |
| `layouts/work.json` | 普段使うレイアウト。紺のガラス風で、上にオフィス、下にステータスバー |
| `mods/` | 自作 mod 5 つ（TypeScript） |
| `themes/` | 取り込んだテーマ（rose-pine、MIT） |
| `types/` | Herdr の型定義の写し（Apache-2.0） |

## mod

| mod | 置き場所 | すること |
|---|---|---|
| `projects` | サイドバー上 | space の一覧。`projects.json` に書いた案件フォルダごとにまとめる。案件にまだ space が無ければ「+ 統括」で、案件フォルダに統括役の Claude を立てる |
| `work-agents` | サイドバー下 | agent の一覧。サブ agent は親の下に畳む。完了した agent に未読の印を付け、Herdr を見ていないときに完了・入力待ちを macOS の通知で知らせる |
| `work-tabs` | 上端 | タブの一覧と、右側のパネル（Files / Changes / Board）とオフィスの出し入れボタン |
| `board` | 右パネル | 案件ボード。案件の repo と worktree ごとに、ブランチ、未コミット数、ahead/behind、そこで動く Claude、PR を出す。既定ブランチに取り込み済みの worktree は、その場で削除できる |
| `claude-limits` | ステータスバー右 | Claude の 5 時間枠と 7 日枠の使用率。マウスを乗せると、リセットまでの時間と使うペースを出す |

`projects` と `board` は `~/.config/herdr-app/projects.json` を読む。案件フォルダの一覧で、手元の環境ごとに違うので repo には入れていない。

```json
["~/Work/案件A", "~/Work/案件B"]
```

`claude-limits` は、Claude Code の statusline が書き出す `~/.cache/claude-limits.json` を読む（書き出す側のスクリプトは dotfiles にある）。

## 開発

mod は `mods/<mod>/main.ts` に TypeScript で書く。`strict` で null チェックも有効。Herdr が読むのは `main.js` だけなので、`build.sh` が esbuild で変換する。

```sh
make check   # 型チェック
make dev     # 変換して ~/.config/herdr-app/mods に置く。Herdr でレイアウトを切り替え直すと読み込まれる
make types   # Herdr を更新したあと、types/ の型定義を取り直す
```

PR と main への push で、CI が型チェックと変換を確かめる。

## 入れ方

[dotfiles](https://github.com/shmorish/dotfiles) の Home Manager が、この repo をコミット固定で取ってきて、変換したものを `~/.config/herdr-app` に実ファイルとしてコピーする。変えたときの流れは次のとおり。

1. ここで変更して `make dev` で試す
2. コミットして push する
3. dotfiles の `nix/dotfiles.nix` で、`herdrConfigSrc` の `rev` と `hash` を上げる
4. `make switch`

Herdr の画面で変えた設定は、次の `make switch` で上書きされる。残したいものは、ここにコミットする。

オフィス（[herdr-office](https://github.com/shmorish/herdr-office)、Moe Office の fork）と Herdr Glass は、この repo ではなく dotfiles 側で取ってくる。

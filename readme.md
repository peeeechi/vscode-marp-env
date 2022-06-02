# Visual Studio Code での Markdown から Slide を作る環境(Marpを使用) <!-- omit in toc -->

- vscodeでMarp と連携して、楽してイイ感じにプレゼン資料を作る時環境を構築する

## TOC <!-- omit in toc -->

- [前提条件](#前提条件)
- [Usage](#usage)
- [Table of Contents(TOC) の作成](#table-of-contentstoc-の作成)
- [参考](#参考)

## 前提条件

- vscode がインストールされていること
- DockerとDocker Composeがインストールされていること
- vscodeに[Remote - Containers](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers)がインストールされていること  

[参考(Remote development in Containers)](https://code.visualstudio.com/docs/remote/containers-tutorial)

## Usage

- このディレクトリでvscode を開く
- ターミナルで `./build-image.sh` 実行
- `F1` -> `Remote-Containers: Rebuild and Reopen in Container` を選択
- 新しく開かれたvscode の `workspace` ディレクトリの中にMarkdownでスライドを書いていく(書き方は[参考](#参考)を参照)

## Table of Contents(TOC) の作成

1. `F1` キーを押下
2. `>markdown all in one: create table of contents` と入力
3. TOCが生成される(以後、保存のたびにリンクが更新される)

TOCから除外したいヘッダーは、ヘッダーに `<!-- omit in toc -->` のコメントを入れる

```md
## Ignores Header  <!-- omit in toc -->
```
(`ignore toc` でsnippet作成済み)

## 参考

### Marp  <!-- omit in toc -->

- [【VS Code + Marp】Markdownから爆速・自由自在なデザインで、プレゼンスライドを作る - Qiita](https://qiita.com/tomo_makes/items/aafae4021986553ae1d8)
- [Marp Basic Example](https://speakerdeck.com/yhatt/marp-basic-example)
- [Marpを使ってmarkdownでスライド資料を作成する](https://dev.classmethod.jp/articles/make-slides-from-markdown-with-marp/)

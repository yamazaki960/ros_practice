# パラメータファイルの書き方
move_base実行時に必要なパラメータについてのメモ。(move_baseについては[こちら](./move_base.md))

パラメータとして，だいたい次の設定ファイルが必要。名前はなんでもいい。
- costmap_common.yaml：グローバルとローカルコストマップのパラメータ，2つに共通するものを書く。
- costmap_global.yaml：グローバルコストマップのパラメータ
- costmap_local.yaml：ローカルコストマップのパラメータ
- planner.yaml：グローバル・ローカルプランナーのパラメータ，それぞれ設定ファイルを分けてもよい。
- move_base.yaml：move_baseのパラメータ，直接launchファイルに書いても良い．

<br>

## 作成方法
以下の内容のyamlファイルを作成する。



# ROS資料

このサイトでは研究室で扱うツールの導入方法や使用方法，エラー対策などについてまとめています．  
それらの知見をみなさんで共有したいと考えています．

また，新しく配属された人がROSの使い方を勉強するためのチュートリアルも兼ねていますので，ぜひ活用してください．

## このサイトの編集方法

### 事前準備

- Githubアカウントの作成．
- PCにGitのインストール
- vscode(Visual Studio Code) のインストール
- Gitを使いやすくするためのvscodeの拡張機能のインストール(GitLens，GitGraph)

### 書き方

事前準備としてこのリポジトリを編集する権限を与える必要がありますが，それに関しては省略します．

このリポジトリをGithubからダウンロードする．
```
git clone https://github.com/tomson784/ros_practice.git
```

ディレクトリ構成は以下のようになっており`src`の部分に編集するファイルが入っています．
```
(root)/
    ├─ .gitignore
    ├─ book.toml
    ├─ docker-compose.yml
    ├─ Dockerfile
    ├─ LICENSE
    ├─ README.md
    ├─.github
    │  └─workflows
    │          main.yml
    └─src
        ├─ index.md
        ├─ SUMMARY.md
        ├─    :
        ├─    :
        ├─    :
```

`src/SUMMARY.md`の内容は以下のような内容になっています．
```markdown
- [このサイトについて](./index.md)
- [chapter-1](./chapter-1/index.md)
    - [section-1-1](./chapter-1/section-1-1.md)
    - [section-1-2](./chapter-1/section-1-2.md)
- [chapter-2](./chapter-2/index.md)
    - [section-2-1](./chapter-2/section-2-2.md)
    - [section-2-2](./chapter-2/section-2-2.md)
```

`src`に対して相対的なパスを設定することで，個別に編集したファイルを章立てでまとめることができます．  
ファイルはマークダウンで書く必要があります．それについては[このサイト](https://qiita.com/Minalinsky_1911/items/b684cfabe0f2fde0c67b)などを調べてみてください．


### 書いた内容を反映する．

編集が終わったらgitを使って変更履歴を更新し，それをアップロードすることで変更内容が反映されます．  
[このリンク](https://tomson784.github.io/memo/git/2021/03/20/git.html)でもgitの使いかたを説明していますが，ここでは必要なコマンドのみ説明します．

以下の手順を行うことで変更内容の反映ができます．
```
git add .
git commit -m "どのような変更を加えたかについて説明"
```

`git remote -v`で以下のような表示が出ると思う．
```
origin  https://github.com/tomson784/ros_practice.git (fetch)
origin  https://github.com/tomson784/ros_practice.git (push) 
```

次のコマンドでGithub上に反映することができる．
```
git push origin main
```

これで終了

## ROSの使い方参考サイト
- [ROS(Robot Operating System)を使う](http://forestofazumino.web.fc2.com/ros/ros_top.html)
- [ロボットシステム学（2020/4s, 6s）](https://lab.ueda.tech/?page=robosys_2020)
- [ロボットシステム学講義](https://www.youtube.com/playlist?list=PLbUh9y6MXvjdIB5A9uhrZVrhAaXc61Pzz)
- [ROS講座](https://qiita.com/srs/items/5f44440afea0eb616b4a)  
- [demura.net AI・ロボットをつくるために](https://demura.net/)
- [ROSの基本的な開発をしよう](https://qiita.com/kazuyamashi/items/53104e2174d2df751868)
- [[ROSロボットプログラミング] ROSで使われる専門用語](https://qiita.com/robotpilot/items/4aa18b0923953165b5dd)


このサイトのソースコードはこちらになります↓  
[**Github Source**](https://github.com/tomson784/ros_practice)






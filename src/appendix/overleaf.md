# Oveleafのセットアップ

論文をTeX文書で書きたかったので、TeX文章用オンラインエディターである「Overleaf」のセットアップを行いました．  
このページではSICE SI2021の[予稿論文](https://sice-si.org/conf/si2021/paper_instructions.html)をOverleafで編集できるようにするまでの流れを示します。  
「Wordで良くね?」って思った方は下記に示す利点を読んで考え直してください。（書いておいてなんですが僕もまだよくわかってません）  

TeX文書の利点   
    ・数式を綺麗に書ける  
    ・参照文献のリスト作成が用意  
    ・文章体裁を整えやすい  

ちなみに参考にしたサイトはこちらです↓  
- [OverLeafで日本語論文(IPSJ向け)を作成する](https://qiita.com/kazutaka708/items/bd474bddf50cb4405c1f)  

#### 手順

1. Overleafのアカウント作成  
    [このサイト](https://github.com/tomson784/ros_tutorial)にアクセスしてアカウントを登録してください。  
    Googleアカウントを利用するのが一番楽だと思います。

2. プロジェクト作成  
    - New ProjectのBlank Projectを選択してプロジェクト名を入力。(今回は「SI2021」とする)
    - SI2021というプロジェクトのフォルダとmain.texができるが、今回はmain.texを削除。
    - [予稿論文](https://sice-si.org/conf/si2021/paper_instructions.html)のLaTex形式による原稿サンプルをダウンロードする。
    - zipを解凍して中の2つのファイルをPC内の任意のフォルダに設置。
    - プロジェクトを開いた状態で画面左上にあるUploadを押して2つのファイルをそれぞれアップロードする。

3. 日本語対応設定  
    日本語の含んでいるTeX文書をコンパイルできるようにするために設定を行います。
    - MenuからCompilerの設定をデフォルトの「pdfLaTex」から「LateX」に変更する。
    - おなじプロジェクト内にNew Fileでlatexmkrcというファイル(拡張子なし)を作成。

 ```latexmkrc
 $latex = 'platex';
 $bibtex = 'pbibtex';
 $dvipdf = 'dvipdfmx %O -o %D %S';
 $makeindex = 'mendex -U %O -o %D %S';
 $pdf_mode = 3;
 ```

最後に画面中央のRecompileを押して右側にフォーマットがプレビューできたら完了です。


#### ※追記

ロボット系の学会にアップロードした際に、<span style="color: red; ">
「アップロードされたPDFファイルが当システム未対応の圧縮形式を利用してる可能性があります。」</span>と表示されることがある。

latexmkrcファイルを作成し，以下のように書くことで対応できる．

```perl
$latex = 'platex'; 
$bibtex = 'pbibtex';
$dvipdf = 'dvipdfmx %O -o %D %S -z 0 -V 4';
$makeindex = 'mendex -U %O -o %D %S';
$pdf_mode = 3; 
```

これでコンパイルしたPDFはそのまま投稿できることを確認した．
（PDFのバージョンを4にする，無圧縮を指定する）

## 参考
- [TexWorksで圧縮解除](http://c-faculty.chuo-u.ac.jp/~hideki/?p=267)

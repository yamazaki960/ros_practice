# YOLOv3 オリジナルデータの学習について
YOLOv3によるオリジナルデータの学習方法についてやり方など説明する。  

・ 学習のみなら,LinuxのほかMacやWindowでもできる。  
・ GPUがないもしくはメモリが小さい(2 GiB程度?)環境では学習できないことに注意。  
・ darknetのほうを見るとYOLOv4による学習もできるらしい。YOLOはv5まである。

## 作業の流れ
1. [準備](#準備)(お好みで)
2. [darknetのインストール](#darknetのインストール)
3. [画像データ収集](#画像データ収集)
4. [画像のアノテーション](#画像のアノテーション)
5. [データの準備](#データの準備)
6. [YOLOv3による学習](#YOLOv3による学習)

以下を参考にした。  
https://demura.net/deeplearning/14458.html  

## 準備  
事前に学習データやdarknetのインストール先のディレクトリをつくっておく。  
整理用。やらなくてもよい。

ディレクトリ構成は以下の通り(一例)


## darknetのインストール
2種類ある  
本家Darknet 　https://pjreddie.com/darknet/yolo/  
AlexeyABのDarknet　https://github.com/AlexeyAB/darknet　**おすすめ**   

- 認識率は両者ほぼ互角らしい。　使い方も同じ[[2]](#参考)
- 本家の方はdarknet_rosに入っているものと同じ。
- AlexeyABのほうは単精度浮動小数点数指定ができるため，認識スピードがかなり向上できる他，学習の経過をグラフで確認できる。

```
$ cd ~/yolo/src
$ git clone https://github.com/pjreddie/darknet.git   
                            or
$ git clone https://github.com/AlexeyAB/darknet.git 
$ cd darknet
$ make
```

## 画像データ収集  

1カテゴリにつき基本は1000枚，推奨は5000~10000枚ぐらいらしい[[3]](#参考)．

収集方法  
- 自分で撮る
- ロボットにカメラを取り付けて移動させながら映像をとる．rosbag で保存．  
    bag データから時間区切りで画像を抽出  
    https://demura.net/misc/14340.html  
- ネットから入手  
    - Google画像検索  
      - 検索結果上位から指定枚数入手[[4]](#参考)(google-images-download)    
        Python3で実行(Windows Anconda3)  
        ```
        $ git clone https://github.com/Joeclinton1/google-images-download.git gid-joeclinton
        ```  
        学習用としては使えないものも混ざるため，精査する必要がある．
 
    - データセットを公開しているサイトから入手[[5]](#参考)  
    アノテーション済みのものもある。AlexeyABのgithubにもデータセットへのリンクを確認。  

        例(使ったもの)  
        - [Open Images Dataset V6](https://storage.googleapis.com/openimages/web/index.html)（アノテーション付き）  
     
            ・ 個々のクラスごとにダウンロードできず，全クラス入る。(600GiB以上)  
            　→ 個別にダウンロードできる[ライブラリ](https://github.com/DmitryRyumin/OIDv6 )を使う．  
            ・ アノテーションされたtxtファイルはYOLO用への変換が必要。  
- データの水増し  
    いろいろプログラムがネット上にある  
    例(使ったもの)  
    - KerasのImageDataGenerator (Windows10 Anaconda3) 参考[[6],[7]](#参考)  
    Python3で動作する．AnacondaやGoogle Colaboratory上でやるといい  

<br>

## 画像のアノテーション
アノテーションとは画像からオブジェクトの領域を矩形で指定する作業。  
いろいろあるが，ここではYolo用のテキストファイルも生成できるtzutalinさんのlabelImgを使う。[参考]()  

① 事前準備

- 

② インストール
```
& cd ~/yolo/src
$ git clone https://github.com/tzutalin/labelImg.git
$ sudo apt install python3-pip
$ cd labelImg
$ sudo pip3 install -r requirements/requirements-linux-python3.txt
$ sudo apt install pyqt5-dev-tools
$ make qt5py3
```

③ 実行方法
- クラスのラベルテキストファイルclass.txtを作る  
  一行に一つのクラスラベルにする
```
$ cd ~/yolo/data/robocup
$ gedit  class.txt
```

- labelImagの起動
```
$ cd ~/yolo/src/labelImg
$ python3 labelImg.py ~/yolo/data/image
```

- labelImgの初期設定
1. [Save]の下にある PscalVOC を選択して，YOLOに変更
2. [View]をクリック,[Auto Saving]と[Single Class Mode]にチェック
3. [Change Save Dir]をクリック，アノテーションファイルを保存するディレクトリをセット

- アノテーション手順
1. 「wキー」を押す。領域選択モードになる。
2. オブジェクト領域を囲む。最初だけ保存先を聞かれるので画像ファイルと同じディレクトにする。
3. 「dキー」を押すと，次の画像に切り替わる。
4. 1~3を繰り返す。

## データの準備
① 学習用データの準備
- データ保存用，ウェイトを保存するためのディレクトリを作成  
```
$ mkdir -p ~/yolo/data/wrs  
$ mkdir -p ~/yolo/data/wrs/backup
```

- アノテーションした全ファイルをデータ保存用ディレクトリに移動

- Yoloの訓練用，テスト用ファイルを作成するプログラムをgithubからクローン
```
$ cd ~/yolo/src
$ git clone https://github.com/demulab/divide_files.git
```
- ビルド・実行
```
$ cd ~/yolo/src/divide_files
$ gcc -o divide_files divide_files.c
$ cd ~/yolo/data/wrs
$ ~/yolo/src/divide_files/divide_files [テストデータの割合]
```  
　　
ここで [テストデータの割合]に全データに対するテストデータの割合を入れる。  
例えば、テストデータを30%にしたければ0.3とする。引数を省略するとテストデータを20%にする。  
成功すると~/data/wrs/train.listと~/data/wrs/test.listができる。

<br>

② 設定ファイルの準備
- データ設定ファイル  
 ~/yolo/src/darknet/cfg ディレクトリの中に以下の内容のデータ設定ファイルを作成  
 ここでは，データ設定ファイル名を __wrs.data__ とする。  
 classes：識別するクラス数  
 train：訓練用ファイル  
 valid：テスト用ファイル  
 names：クラス名ファイル  
 backup：学習の途中のウェイトを保存するディレクトリ
 
 ```wrs.data
classes=3
train = /home/user_name/data/wrs/train.list
valid = /home/user_name/data/wrs/test.list
names = /home/user_name/data/wrs/names.list
backup = /home/user_name/data/wrs/backup
```
- クラス名ファイル  
識別するクラス名。 ~/yolo/data/wrs/ 内  
ここでは，ファイル名を __names.list__ とし，各クラスに名前をつける。

```names.list
onigiri
sandwich
bento
```

- ネットワーク設定  
1. Yoloのネットワークを設定するファイル。~/yolo/src/darknet/cfg/ 内  
ここでは，訓練用の設定ファイル名を __wrs_train.cfg__ とする。  
```
cd ~/src/darknet/cfg
cp yolov3-voc.cfg  wrs_train.cfg
```
  
2. __wrs_train.cfg__ の１〜7行目を以下のように変更する。
  
```
# Testing
#batch=1
#subdivisions=1
# Training
batch=64
subdivisions=16 # 16
```
3. wrs_train.cfg の `classes` と `filters` を変更。   
filters=(クラス数+5)*3  
行数は変わるため目安，`filters=75`，`classes=20`で検索して変更。
```
605行目 filters=24
611行目 classes=3
689行目 filters=24
695行目 classes=3
773行目 filters=24
779行目 classes=3
```

③ ネットワークのウェイトを保存する間隔を変更  
　__~/src/darknet/examples/detector.c__ では、ネットワークのウェイトを保存する間隔は138行目で次のようになっている。  
　つまり、学習回数が1000回未満のときは100回毎に保存，それ以降は10000回毎に保存される。  
　なお，ウェイトはデータ設定ファイルでしたディレクトリbackupに保存。  
　`if (i%10000==0 || (i < 1000 && i%100 == 0)) {`  
　これを20000回までは1000回毎にも保存したければ次のように変更する。  
　`if (i%10000==0 || (i <= 1000 && i%100 == 0)||  (i <=20000 && i % 1000 ==0)) {`


<br>

## YOLOv3 による学習
1. Imagenetで学習済みのウェイトを使うためダウンロード  
```
$ cd ~/src/darknet
$ wget https://pjreddie.com/media/files/darknet53.conv.74
```
2. 次のコマンドで学習する。
```
$ cd ~/src/darknet
コンピュータにNVIDIAのGPUを1個搭載している場合
$ ./darknet detector train cfg/wrs.data cfg/wrs_train.cfg darknet53.conv.74
GPUを2個搭載している場合
$ ./darknet detector train cfg/wrs.data cfg/wrs_train.cfg darknet53.conv.74 -gpus 0,1
```
- 学習の終了条件は、wrs.cfgファイルの20行目で50万200回と大きな値になっているので適宜変更。  
`max_batches = 500200`

- 学習するクラス数に合わせて、最大バッチ回数を指定．学習するクラス数×2000。  
ただし，学習させる画像の数や6000回を下回らない様に．22行目にstepsをmax_batchesの80%と90%に。

- 学習中のLogや評価指標について [[2],[3]](#参考) を参考にする。

- 学習の際にはGPUを使用するが，GPUのメモリが小さい(自分の場合 2GiB)とメモリアウトしてしまい学習できない場合がある．
バッチサイズやネットワークサイズを小さくすることで解決できる可能性もあるが精度は下がってしまう。  
→ Google Colaboratory上で学習を行う．

<details><summary>Google Colaboratory上での学習</summary>
　1. 学習までの準備は終わらせておく。<br>
　2. darknetを圧縮し，Google Drive上にアップロード<br>
　3. google colaboratoryを開く。Drive上で右クリックし「アプリで開く」<br>
　4. 「ランタイム」タブから「ランタイムのタイプを変更」を選択し、Python3 とGPUを選択 <br>
　5. 左のファイルからドライブをマウント <br>
　6. YOLOv3_train.ipynbの通りにセルの実行 <br>

　<details><summary>注意</summary>

- Google Colabでは実行のセッションが切れてから90分経過するとランタイムがリセットされる。<br>
実行中の処理は強制停止する。<br>
→ ９０分に一度はPCを触る <br>
→ 放置する際は，アドオン機能「AutoRefresh」による自動リロードやコマンドラインからスクリプトで定期的にアクセスするなど対策する．  
- 新しいインスタンスを起動してから12時間経過すると、ノートブックのセッションの接続有無にかかわらず起動したノートブックは強制的に初期化されてしまう．  
→ 気にする必要なし。学習結果は適宜Google Drive上に保存される．
</details>
</details>

<br>

## 問題と対処

## 参考
[1] [YOLO V3：オリジナルデータの学習](https://demura.net/deeplearning/14458.html)  
[2] [AlexeyABのDarknetを使った学習について](http://takesan.hatenablog.com/entry/2019/01/11/134128)  
[3] [darknetのパラメータや動作について](https://www.nakasha.co.jp/future/ai/yolov3train.html)  
[4] [google image downloadが動かなかったのでその対応](https://qiita.com/taedookim/items/63759e79426514c8a729)   
[5] [機械学習用データベースのリンクまとめ](https://qiita.com/ulwlu/items/90dd8d79b12e10606299)  
[6] [Kerasを使用して画像のデータ拡張（回転、拡大・縮小）を行う](https://newtechnologylifestyle.net/keras_imagedatagenerator/)  
[7] [[ keras ] ImageDataGenerator で画像データを加工して増やす(データ拡張)](http://wild-data-chase.com/index.php/2019/02/04/post-370/)
[8] [Yolo学習用データセットの作成ツール：labelImg](https://demura.net/deeplearning/14350.html)
    
     

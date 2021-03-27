# YOLOv3 オリジナルデータの学習について

作業の流れ
- darknet のパッケージを入れる．（darknet_ros をいれるときに一緒に入っているものを使用してもよい）
- 写真をとる．画像データ収集
- 画像をアノテーションソフトを使って対象物の範囲を指定する．
- 画像ファイルとアノテーションで作成した範囲のデータのtxt ファイルを使い、train,test用データに分ける
- 学習用データを使って、学習させる（yolov3）

基本的に以下のとおりに進める．  
https://demura.net/deeplearning/14458.html  

## darknetのパッケージ

2種類ある　
本家Darknet 　https://pjreddie.com/darknet/yolo/  
解説　　　　How to train YOLOv2 to detect custom objects  

AlexeyAB さんのDarknet　https://github.com/AlexeyAB/darknet  
解説も含む  

- 認識率は両者ほぼ互角らしい。（確認はしてない）　使い方も同じ[1]
- 本家の方はdarknet_rosに入っているものと同じ
- AlexeyABのほうは単精度浮動小数点数指定ができるため、認識スピードがかなり向上できる他、  
学習の経過をグラフで確認できる．（とても便利）  
→　こちらを使うほうがいいかも

コマンド

本家 `git clone https://github.com/pjreddie/darknet.git`  
AlexeyAB `git clone https://github.com/AlexeyAB/darknet.git`  

## データ収集  

1カテゴリにつき基本は1000枚，推奨は5000~10000枚ぐらいらしい[2]．

収集方法
- 自分で撮る
    - ロボットにカメラを取り付けて移動させながら映像をとる．rosbag で保存．  
    bag データから時間区切りで画像を抽出  
    https://demura.net/misc/14340.html  
    - ネットから入手  
    - Google画像検索から入手．google-images-download を使用．(Python3)  
    学習用としては使えないものも混ざるため，精査する必要がある．  
    githubから直接ダウンロード，pip installで入れると上手く動かない．  
    https://qiita.com/taedookim/items/63759e79426514c8a729  
    - データセットを公開しているサイトから入手[3]．アノテーションされているものもある．  
    AlexeyABのgithubにもデータセットへのリンクを確認．  
    - 使ったもの  
    Open Images Dataset V6（アノテーション付き）  
    https://storage.googleapis.com/openimages/web/index.html  
    上記からは個々のクラスごとにダウンロードすることができず，全クラス入ってしまう．(600GiB以上)  
    そのため，githubから個別にダウンロードできるコードを使う．  
    https://github.com/DmitryRyumin/OIDv6  
    アノテーションされたtxtファイルもダウンロードできるが，そのままでは学習に使えないのでYOLO用に変換する必要がある．  
- データの水増し  
    - いろいろプログラムがネット上にある  
    使ったもの  
    KerasのImageDataGenerator (Windows10 Anaconda3)  
    Python3で動作する．AnacondaやGoogle Colaboratory上でやるといい  
    https://newtechnologylifestyle.net/keras_imagedatagenerator/  
    http://wild-data-chase.com/index.php/2019/02/04/post-370/  


## YOLOv3 による学習
- 学習するクラス数に合わせて、最大バッチ回数を指定．学習するクラス数×2000。  
ただし，学習させる画像の数や6000回を下回らない様に．22行目にstepsをmax_batchesの80%と90%に．  
- 学習中のLogや評価指標について[1][4]，参考にする．  
- 学習の際にはGPUを使用するが，GPUのメモリが小さい(自分の場合 2GiB)とメモリアウトしてしまい学習できない場合がある．
バッチサイズやネットワークサイズを小さくすることで解決できる可能性もあるが精度は下がってしまう．  
→ Google Colaboratory上で学習を行う．

Google Colaboratory上での学習
1. 学習までの準備は終わらせておく．
2. darknetを圧縮し，Google Drive上にアップロード．
3. google colaboratoryを開く．Drive上で右クリックし「アプリで開く」から
4. 「ランタイム」タブから「ランタイムのタイプを変更」を選択し、Python3 とGPUを選択する。
5. 左のファイルからドライブをマウントする．
6. YOLOv3_train.ipynbの通りにセルの実行

(注意)
- Google Colabでは実行のセッションが切れてから90分経過するとランタイムがリセットされる．  
実行中の処理は強制停止する．  
→ ９０分に一度はPCを触る  
→ 放置する際は，アドオン機能「AutoRefresh」による自動リロードやコマンドラインからスクリプトで定期的にアクセスするなど対策する．  
- 新しいインスタンスを起動してから12時間経過すると、ノートブックのセッションの接続有無にかかわらず起動したノートブックは強制的に初期化されてしまう．  
→ 気にする必要なし．今回の場合，学習結果は適宜Google Drive上に保存される．  

## 参考
1. http://takesan.hatenablog.com/entry/2019/01/11/134128
2. https://www.nakasha.co.jp/future/ai/yolov3train.html
3. https://qiita.com/ulwlu/items/90dd8d79b12e10606299
4. https://www.nakasha.co.jp/future/ai/yolov3train.html
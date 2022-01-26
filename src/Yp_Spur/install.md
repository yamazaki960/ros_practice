# ROSで動かすための導入

ROSでロボットを動かすためにいくつかインストールが必要になる。  
ここでは、その手順を説明する。

## 手順

1. 制御プラットフォーム [yp-spur をインストール](#yp-spur)  
2. パラメータ [yp-robot-params をインストール](#yp-robot-params)  
3. ROSのパッケージ [ypspur_ros をインストール](#ypspur_ros)

## yp-spur 
  移動ロボット用の走行制御プラットフォーム  
  これがマイコンとの通信・オドメトリ計算・走行制御を行なっている。
  [[1]](https://www.roboken.iit.tsukuba.ac.jp/platform/wiki/yp-spur/how-to-install)参考

  ```
  (yp-spurをクローンする)
  $ git clone http://www.roboken.iit.tsukuba.ac.jp/platform/repos/yp-spur.git
  $ cd yp-spur/
  (robokenブランチに移動する)
  $ git branch roboken origin/roboken
  $ git checkout roboken
  (インストール)
  $ ./configure
  $ make
  $ sudo make install
  $ sudo ldconfig
  ```

## yp-robot-params
  ロボットのパラメータファイル  
  [リンク](http://gofile.me/5YJb7/SIx19rFcj)からダウンロード

  (注) ロボットに合わせているので使いまわしている。基本は変更×

## ypspur_ros
  このパッケージは、 YP-Spur車両制御バックエンド用のROSラッパーノードを提供します。ラッパーノードは、車両制御、デジタルIO、A / D入力、マルチDOFジョイント制御など、YP-Spurが提供するほぼすべての機能をサポートします。

  ```
  $ roscd
  $ cd ../src
  $ git clone https://github.com/openspur/ypspur_ros.git
  $ cd ..
  $ catkin_make
  ```

## 参考
[YP-Spur インストール手順](https://www.roboken.iit.tsukuba.ac.jp/platform/wiki/yp-spur/how-to-install)  
[openspur/ypspur_ros](https://github.com/openspur/ypspur_ros)
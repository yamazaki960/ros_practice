# RealSenseのROSでの導入について

必要なこと  
1. Intel RealSense SDK をインストール（RealSenseからデータを取得するためのC++のライブラリ)
2. ROSラッパーのインストール

## 動作環境

以下のPCで動作を確認した。

| PC | RAM | OS | ROS version |
|:-:|:-:|:-:|:-:|
| mouse-pc（古いパソコン） | 32 GB | Ubuntu 16.04 | Kinetic |
| ONE-NETBOOK OneMix3Pro (小さいやつ) | 8 GB | Ubuntu 18.04 | Melodic |
| GALLERIA GCR2070RGF-QC | 16 GB | Ubuntu 18.04 | Melodic |
<br>

## 1. Intel RealSense SDKのインストール

[[1]](https://demura.net/robot/16525.html)の通り, 以下のコマンドをターミナルにうつ。  

① サーバーの公開鍵を登録 ( 更新されていることがあります。うまくいかなかったら[[2]](https://github.com/IntelRealSense/librealsense/blob/master/doc/distribution_linux.md)参照)
```
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-key F6E65AC044F831AC80A06380C8B3A55A6F3EFCDE || sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-key F6E65AC044F831AC80A06380C8B3A55A6F3EFCDE
```
② リポジトリにIntelサーバーを追加  
Ubuntu 16,18,20 LTS:
```
sudo add-apt-repository "deb https://librealsense.intel.com/Debian/apt-repo $(lsb_release -cs) main" -u
```

③ ライブラリのインストール
```
$ sudo apt update
$ sudo apt install librealsense2-dkms
$ sudo apt install librealsense2-utils
$ sudo apt install librealsense2-dev
$ sudo apt install librealsense2-dbg
```

④ 動作確認  
　RealSenseのUSBケーブルを抜き差しして以下のコマンドを実行する。  
　ウインドウが開くので、左サイドバーにあるStereo ModuleとRGB Cameraをoffからonにして表示されたらOK。
```
$ realsense-viewer
```

⑤ 次のコマンドを実行して, `realsense` の文字列があれば成功,なくても動けばよし．

```
modinfo uvcvideo | grep "version:"
```
<br>

## 2. ROSラッパーのインストール

① githubからクローンする。以下を実行。  
　`catkin_make` は `catkin build` でも問題なし

```
$ cd ~/catkin_ws/src
$ git clone https://github.com/pal-robotics/ddynamic_reconfigure.git
$ catkin_make
$ git clone https://github.com/IntelRealSense/realsense-ros.git
$ catkin_make
```

② 動作確認
　以下を実行して，トピックを確認できればOK。
```
roslaunch realsense2_camera rs_camera.launch
```


## 問題と対処

1. mouse-pc で行った際, SDKをいれるとRealSenseが使えないどころか/dev/video*が
でなくなる（その他のカメラも使えなくなる）  
→ <span style="color: red; ">カーネルを4.4.0.193から4.5.0.122に更新</span>  
　[カーネルバージョン変更方法](https://qiita.com/ego/items/36e9baccc80097950195)  
　再起動後Ubuntuが起動できなくなる場合があるので，注意して行う。  

    <details><summary> 確認したこと </summary>
    → `lsusb -t` でドライバ確認　ドライバーが割り当てられていない(uvcvideo)<br>
    → `uvcvideo`へのパスが変わっている<br>
    　`/lib/modules/4.4.0-193-generic/updates/dkms/uvcvideo.ko`<br>  
    　本来は`/lib/modules/4.4.0-193-generic/kernel/drivers/media/usb/uvc`にある<br>
    → `modinfo uvcvideo | grep "version:"` で調べるとrealsenseの文字が入っている<br>  
    　動作確認済みのUbuntu18.04でも同じ表示だが，もとのversion:1.1.1のまま問題なく使える<br>  
    → `/lib/modules/4.4.0-193-generic/updates/dkms/uvcvideo.ko`を削除し, もとの`uvcvideo.ko`をコピーしたところ、`/dev/video*`がでて,`realsense-viewer`でカメラ映像を読み取れた。同時にその他のカメラも使えるように。<span style="color: red; ">非推奨</span>  <br>
    →カーネル4.4.0.187以降の4.4シリーズでは上手く動作しないことがあるらしい。[3](https://github.com/IntelRealSense/librealsense/issues/7287)
    </details>
    

<br>

## 参考
[1] [Ubuntu18.04: RealSense D435iをROS Melodicで使う](https://demura.net/robot/16525.html) <br>
[2] [Intel® RealSense™](https://github.com/IntelRealSense/librealsense/blob/master/doc/distribution_linux.md) <br>
[3] [All USB cameras are not working anymore after librealsense-dkms update](https://github.com/IntelRealSense/librealsense/issues/7287)

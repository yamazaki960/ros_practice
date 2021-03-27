# RealSenseのROSでの導入について

必要なこと
- Intel RealSense SDK をインストール（RealSenseからデータを取得するためのC++のライブラリ）
- ROSラッパーのインストール

## 動作環境

| PC | RAM | OS | ROS version |
|:-:|:-:|:-:|:-:|
| mouse-pc（山内さんのパソコン） | 32 GB | Ubuntu 16.04 | Kinetic |
| ONE-NETBOOK OneMix3Pro (小さいやつ) | 8 GB | Ubuntu 18.04 | Melodic |

## Intel RealSense SDK && ROS ラッパーのインストール

以下のサイトの通り  
https://demura.net/robot/16525.html

ページ中で`catkin build`を使っているが`catkin_make`でも問題なし。

次のコマンドを実行してrealsenseの文字列があれば成功,なくても動けばよし．

```
modinfo uvcvideo | grep “version:”
```

## 詰まったこと

mouse-pc で行った際, SDKをいれるとRealSenseが使えないどころか/dev/video*が
でなくなる（その他のカメラも使えなくなる）  
→ <span style="color: red; ">カーネルを4.4.0.193から4.5.0.122に更新</span>  
カーネルバージョン変更方法，再起動後Ubuntuが起動できなくなる場合があるので，注意  
https://qiita.com/ego/items/36e9baccc80097950195  

以下，確認したこと

→ `lsusb -t` でドライバ確認　ドライバーが割り当てられていない(uvcvideo)  
→ `uvcvideo`へのパスが変わっている  
`/lib/modules/4.4.0-193-generic/updates/dkms/uvcvideo.ko`  
本来は`/lib/modules/4.4.0-193-generic/kernel/drivers/media/usb/uvc`にある  
→ `modinfo uvcvideo | grep "version:"` で調べるとrealsenseの文字が入っている  
公式ではそうなると書いてあるが動作確認済みのUbuntu18.04ではその文字は入っておらず，もとのversion:1.1.1のまま問題なく使える  
→ さきほどの`/lib/modules/4.4.0-193-generic/updates/dkms/uvcvideo.ko`を削除し,  
もとの`uvcvideo.ko`をコピーしたところ，`/dev/video*`がでて,`realsense-viewer`でカメラ
映像を読み取れた．同時にその他のカメラも使えるように．ただし<span style="color: red; ">非推奨</span>  
→カーネル4.4.0.187以降の4.4シリーズでは上手く動作しないことがあるらしい．  
以下に詳しくある

https://github.com/IntelRealSense/librealsense/issues/7287
# デュアルブート(Nvidia GPU あり)

デュアルブートで躓いている人(ログインループになる，GPUが認識されない，など)が多い印象だったので，自分が参考にしたサイトのURLを載せておきます．
- [【上級者向け】Ubuntuをデュアルブートする《その１：既にWindowsが入っているSSD・HDDにUbuntuを入れる》](https://guminote.sakura.ne.jp/archives/233)  
- [【Ubuntu】NVIDIAドライバ・CUDA・CUDNNをインストールして深層学習環境を整える](https://guminote.sakura.ne.jp/archives/328)  


このサイトの方法に従ってやったら，GPUが認識されました．
使用したPCはGALLERIAです．

---

（追記：2021.03.25）
nvidia-driverのバージョンとカーネルのバージョンの組み合わせによっては、
起動できない場合が確認できたので、知見としてまとめます．

#### 動作スペック

使用したPC：ROG Zephyrus G14 GA401 GA401IV-R9R2060WLQ
 - CPU　AMD Ryzen™ 9 4900HS
 - GPU　NVIDIA® GeForce RTX™ 2060 Max-Q 6GB
 - OS　　Ubuntu 18.04.5 LTS
 - [詳しいスペック](https://rog.asus.com/jp/laptops/rog-zephyrus/rog-zephyrus-g14-series/spec)

#### 正常に起動できたバージョン

-  Nvidia driver　nvidia-driver-450
```sudo apt-get install nvidia-driver-450```
-  Linux kernel　linux-image-5.4.0-70-generic
```sudo apt-get install linux-image-5.4.0-70-generic```

これ以外のバージョンの組み合わせはうまく行きませんでした．．
Kernelについて、このバージョン以外は、Wifiアダプタ+マウスパッドの認識もされませんでした．もしも、これらの認識がされない人は、Kernelの変更も行ってみてください．

- [Ubuntu カーネルのバージョン変更](https://qiita.com/ego/items/36e9baccc80097950195)

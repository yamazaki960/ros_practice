# ROSでdarknet_ros(YOLO)の導入


## 必要なこと

- darknet_rosのパッケージを入れる。
- YOLOでGPUを使う場合(CPUのみだと基本遅い，リアルタイムで処理したいなら使う)，NAVIDIA ドライバ，CUDA，cuDNNを入れる。
- カメラにRealSenseを使用する場合，RealSenseのROSでの導入についてを参照

## darknet_ros の導入
- 以下のとおりにインストール。
　https://demura.net/robot/16542.html
- 動作が確認できたらGPU処理の設定に `darknet/Makefile` を以下に変更

```darknet/Makefile
GPU=1
CUDNN=1
OPENCV=0
OPENMP=0
DEBUG=0
```

動作させてfpsが変化していないようならGPUを使えるように設定する。

## GPU の設定()

NVIDIA Driver, CUDA Toolkit, cuDNNのインストールが必要。  
NVIDIA Driver, CUDAが入っているのか一度確認する。  

```　　
nvidia-smi
```

もし入れなおしたいとき場合，次で削除

```
sudo apt --purge remove "cublas*" "cuda*"
sudo apt --purge remove "nvidia*"
rm -rf /usr/local/cuda*
sudo apt-get autoremove && sudo apt-get autoclean
```

## NVIDIA Driver(CUDAのインストール中に勝手に入る)
1. まずGPUを確認する。
```
lspci | grep -i nvidia
```
2. 推奨ドライバを確認 recommendedとなっているもの
```
ubuntu-drivers devices
```

・CUDA, cuDNN
1. 何もないことを確認
```
dpkg -l | grep cuda
```
2. 以下に従って行う。バージョンなどはしっかり確認すること(1)。  
https://qiita.com/yukoba/items/3692f1cb677b2383c983  
ドライバとCUDAの対応を確認(2)。

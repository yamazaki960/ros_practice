# ROSでdarknet_ros(YOLO)の導入

ROSでカメラを用いた物体検出・認識ができる。  
認識された物体はラベル付けとその座標群がトピックとしてパブリッシュされる。

## 必要なこと

- darknet_rosのパッケージを入れる。
- YOLOでGPUを使う場合，NAVIDIA ドライバ，CUDA，cuDNNを入れる。
- カメラにRealSenseを使用する場合，別途[ROS用のライブラリ](../realsense_ros/install.md)を入れる。

## darknet_ros の導入
インストールは[このサイト](https://demura.net/robot/16542.html)に従って以下のように行う。

① SSH keyの設定  
　Ubuntuとgithubで設定しないとインストールできないとある。  
　設定しなくてもできるという例もあるので省略。うまくいかなかったらやる。

② ライブラリのインストール&ビルド  
　ビルドに少し時間がかかる。

```
$ cd ~/catkin_ws/src
$ git clone --recursive git@github.com:leggedrobotics/darknet_ros.git
$ cd ..
$ catkin_make -DCMAKE_BUILD_TYPE=Release
                  or
$ catkin build -DCMAKE_BUILD_TYPE=Release
```

③ 重みファイルのダウンロード  
　学習済みの重みデータ。お好みで。ビルド時にいくつか自動でダウンロード済み。  
　以下のファイル確認  
&emsp;~/catkin_ws/src/darknet_ros/darknet_ros/yolo_network_config/weights/how_to_download_weights.txt

④ テスト  
- カメラの起動  
  ここではRealSenseの例のみ。Webカメラも使える。

```
$ roslaunch realsense2_camera rs_camera.launch
```

- darknet_ros起動  
  かなり重い。数fps程度。
```
$ roslaunch darknet_ros yolo_v3.launch
```
&emsp;GPUを使う場合, `darknet/Makefile` を以下に変更。

```darknet/Makefile
GPU=1
CUDNN=1
OPENCV=0
OPENMP=0
DEBUG=0
```

&emsp;動作させてfpsが変化していないようならGPUを使えるように設定する。次を参照。

## GPU の設定(Nvidia限定)

NVIDIA Driver, CUDA Toolkit, cuDNNのインストールが必要。  
CUDAは対応したバージョンを選ぶ。
以下の手順で決めると良い。
1. Driverのバージョン確認
2. Driverのバージョンに応じて，CUDAのバージョン決定
3. CUDAのバージョンに応じて，cuDNNのバージョン決定  
   Tensorflowを使うor予定の場合，さらに制限

<u>__Driver,CUDA,cuDNNの確認__</u>
- NVIDIA Driverが入っているのか一度確認する。  

```　　
nvidia-smi
```
　表示されれば入っている,CUDA のバージョンも表示されるがドライバが対応している CUDA のバージョンを表示しているに過ぎない。

- もし入れなおしたい場合，次で削除

```
sudo apt --purge remove "cublas*" "cuda*"
sudo apt --purge remove "nvidia*"
rm -rf /usr/local/cuda*
sudo apt-get autoremove && sudo apt-get autoclean
```

<u>__NVIDIA Driverのインストール(CUDAのインストール中に勝手に入る)__</u>

1. まずGPUを確認する。
```
lspci | grep -i nvidia
```
2. 推奨ドライバを確認 recommendedとなっているを入れる。
```
ubuntu-drivers devices
```

<u>__CUDAのインストール(CUDAのインストール中に勝手に入る)__</u>
1. 何も表示されないことを確認
```
dpkg -l | grep cuda
```
2. [こちら](https://qiita.com/yukoba/items/3692f1cb677b2383c983)に従って行う。下図より<span style="color: red; ">ドライバとCUDAの対応を確認</span>。参照元[[1]](https://docs.nvidia.com/cuda/cuda-toolkit-release-notes/index.html)(2021.8.12時点)


<img src="./cuda_version_list.png" width="400px"/>

3. 次のコマンドでドライバーが正しいこととCUDAのバージョンが表示されるのを確認
```
navidia-smi
nvcc -V
```

<u>__cuDNNのインストール__</u>

<br>

## 動作確認例

| PC | RAM | OS | ROS version | CPU | GPU |
|:-:|:-:|:-:|:-:|:-:|:-:|
| mouse-pc（山内さんのパソコン） | 32 GB | Ubuntu 16.04 | Kinetic |CPU：Intel(R) Core(TM) i7-6700HQ CPU @ 2.60GHz | GPU： NVIDIA Corporation GM206M [GeForce GTX 965M] |

成功したもの

Nvidia Driver : 455.32.00, CUDA : 9.0, cuDNN : 7.6.5

darknet_ros.launch<br>
単眼カメラ　　50-70 fps<br>
D455 　　　　50-70 fps  

yolo_v3.launch  
単眼カメラ　　10 fps<br>
D455 　　　　10fps  
→カメラのよる違いなし  

## 問題と対処
導入する過程で起こった問題とその対処について追記していきます。

1. CUDAv10.1を用いた場合,catkin_makeでエラーがでる。特定のLibraryへのアクセスが出来ない。  
→ <span style="color: red; ">CUDAのバージョンを変更して解決</span> 
　　<details><summary> 確認したこと </summary>
   → /usr/local にcuda,cuda-10.1の他にcuda-10.2のフォルダが存在  
   → 必要なヘッダファイルがわけられていまい，パスが通らないことが原因？  
   → 同様のエラーがでている報告があるが，問題ない場合もある。Ubuntuのバージョン？ドライバ？  
   </detail> 

## 参考
1) [Nvidia GPUとCUDAの対応 (Table.3参照)](https://docs.nvidia.com/cuda/cuda-toolkit-release-notes/index.html) 
2) [TensorFlow](https://www.tensorflow.org/install/source?hl=ja#gpu_support_2) 


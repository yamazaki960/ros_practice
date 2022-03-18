# Dockerの使い方

## OS環境とソフトウェアをまるごとパッケージ化して使用する場合


Dockerコンテナを起動し，プログラムを`git clone`などで全て込みでインストールして保存する．
コンパイル済ませてからイメージを保存すれば，コンテナを起動するだけでソフトウェアを実行することができる．

もろもろのROSパッケージのインストールとコンパイルをしてから，コンテナをイメージとして保存する．
```
docker commit <container id> <image name>:<tag>
```

他人に作成したイメージを渡せるように，イメージを圧縮ファイルとして出力する．
```
docker save -o <save file name>.tar <image name>:<tag>
```
圧縮されたイメージファイルをdocker imageとして展開する．
```
docker load -i <save file name>.tar
```

以下のスクリプトによってDockerコンテナを実行することができる．

```bash
USER_ID="$(id -u)"
XSOCK=/tmp/.X11-unix
XAUTH=$HOME/.Xauthority

VOLUMES="--volume=$XSOCK:$XSOCK:rw
         --volume=$XAUTH:$XAUTH:rw"

IMAGE="docker_image_name:tag(ros_distro)"

xhost +local:docker
docker run \
    -it --rm \
    $VOLUMES \
    --env="XAUTHORITY=${XAUTH}" \
    --env="DISPLAY=${DISPLAY}" \
    --env="USER_ID=$USER_ID" \
    --net=host \
    --privileged \
    $IMAGE 
xhost -local:docker
```
ただし，GPUが使用可能な状態となっているPCでは`--runtime=nvidia`というオプションを

ROSの場合はホストとコンテナでnetworkを共有することで，コンテナが出力するTopicをホスト側から参照することができる．
それによって他人が作成したパッケージを，自分のソフトウェアと連携させることが可能となる．

Dockerコンテナ内のコードを改良したい場合はコンテナの中に入る必要があるので，この方法はソフトウェアの開発にはあまり向かない．

## OS環境のみをパッケージ化してソフトウェア開発を行いたい場合

Dockerコンテナ環境にホスト側のフォルダをマウントする．

この実行方法はホスト側からファイルの操作ができるので，ソフトウェア開発に向いている．  
ただし，コンテナを毎回削除するオプションをつけている人はコンパイルを毎回行う必要がある．  

ROSの場合の使い方
ROSで複数パッケージで動作するソフトウェア開発をする場合の手順
適当なディレクトリを作成し，そこにROSパッケージ群を配置する．
さらにROSパッケージ群と同じ階層に`docker run ...`するためのbashファイルを作成する

例）
```
packge-root
      |
      --- ros-package-A
      |
      --- ros-package-B
      |
      --- ros-package-C
      |
      ...
      ...
      ...
      |
      --- docker_run.sh
```

あくまで一例．ディレクトリをマウント場合はホスト側とコンテナ側でそれぞれ環境に合わせてPathを設定する必要がある．
以下のコードが，起動スクリプトの一例である．
```bash
USER_ID="$(id -u)"
XSOCK=/tmp/.X11-unix
XAUTH=$HOME/.Xauthority

VOLUMES="--volume=$pwd:/<ros workspace>/src:rw
         --volume=$XSOCK:$XSOCK:rw
         --volume=$XAUTH:$XAUTH:rw"

IMAGE="docker_image_name:tag(ros_distro)"

xhost +local:docker
docker run \
    -it --rm \
    $VOLUMES \
    --env="XAUTHORITY=${XAUTH}" \
    --env="DISPLAY=${DISPLAY}" \
    --env="USER_ID=$USER_ID" \
    --net=host \
    --privileged \
    $IMAGE 
xhost -local:docker
```

## 注意
クローズドな環境ではこれで十分だが，セキュリティに関しては全然調査してないので気を付けてください

## セキュリティ関連のサイト
- [Top 20 Docker Security Best Practices: Ultimate Guide](https://blog.aquasec.com/docker-security-best-practices)

## 参考
- [generic/run.sh · master · Autoware Foundation / MovedToGitHub / docker · GitLab](https://gitlab.com/autowarefoundation/autoware.ai/docker/-/blob/master/generic/run.sh)

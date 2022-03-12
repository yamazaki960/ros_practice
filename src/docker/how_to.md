# Dockerの使い方


## OS環境とソフトウェアをまるごとパッケージ化して使用する場合

### 出来上がったOS環境とその中ので動作するソフトウェアを使いたいだけの場合

全て込みでインストールして保存

コードを改良したい場合はコンテナの中に入る必要がある．

コンパイル済ませてからイメージを保存すれば，コンテナを起動するだけでソフトウェアを実行することができる．

もろもろのROSパッケージのインストールとコンパイルをしてから，コンテナをイメージとして保存する．
```
docker commit <container id> <image name>:<tag>
```

他人に圧縮ファイル形式で渡せるように，イメージを圧縮ファイルとして出力する．
```
docker save -o <save file name>.tar <image name>:<tag>
```

圧縮されたイメージファイルをdocker imageとして展開する．
```
docker load -i <save file name>.tar
```

### OS環境とソフトウェアをまるごとパッケージ化して保存したい場合

## OS環境のみをパッケージ化してソフトウェア開発を行いたい場合

フォルダのマウント

ホスト側からファイルの操作ができるので，開発に向いている．

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

```bash
USER_ID="$(id -u)"
XSOCK=/tmp/.X11-unix
XAUTH=$HOME/.Xauthority

VOLUMES="--volume=$XSOCK:$XSOCK:rw
         --volume=$XAUTH:$XAUTH:rw"

# IMAGE=$IMAGE_NAME:$ROS_DISTRO
IMAGE="doccker_image_name:tag(ros_distro)"

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


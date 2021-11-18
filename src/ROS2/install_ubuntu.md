# ubuntuでのROS2インストール方法


## 導入環境

| OS | ROS version | ROS2 version |
|:-:|:-:|:-:|
| Ubuntu 20.04 | Noetic | Foxy |

ubuntuのバージョンとそれに対応するものをインストールしてください。
<br>

## .bashrcを変更

vimで.bashrcを開く。
```
$ vim ~/.bashrc
```
すでにROSが入っている場合、.bashrcの以下に相当する箇所をコメントアウトしておく。
```
# source /opt/ros/noetic/setup.bash
# source ~/catkin_ws/devel/setup.bash
```
変更した設定を反映する。
```
$ source ~/.bashrc
```

## APTリポジトリの追加

```
$ sudo apt update && sudo apt install curl gnupg2 lsb-release
$ sudo curl -sSL https://raw.githubusercontent.com/ros/rosdistro/master/ros.key  -o /usr/share/keyrings/ros-archive-keyring.gpg

$ echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/ros-archive-keyring.gpg] http://packages.ros.org/ros2/ubuntu $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/ros2.list > /dev/null
```

## ROS2インストール

```
$ sudo apt update
$ sudo apt install ros-foxy-desktop
```
インストール後、環境設定する。
```
source /opt/ros/foxy/setup.bash
```
## colconのインストール

ROS2をビルドするためにcolconをインストールする。
```
$ sudo apt install python3-colcon-common-extensions
```
## ROS2 コマンド自動補完のインストール

colcon インストール時に既に入っていれば不要。
```
$ sudo apt install python3-argcomplete
```

## ワークスペースの作成

```
$ mkdir -p ~/ros2_ws/src
$ cd ros2_ws/
$ colcon build
```
## 動作確認

ターミナルを開いて以下を実行する。
```
$ source /opt/ros/foxy/setup.bash
$ ros2 run demo_nodes_cpp talker
```
別のターミナルで以下を実行する。
```
$ source /opt/ros/foxy/setup.bash
$ ros2 run demo_nodes_py listener
```
taikerとlistenerからメッセージが出ていれば成功。


## 参考

[1]https://docs.ros.org/en/foxy/Installation/Ubuntu-Install-Debians.html
[2]https://qiita.com/porizou1/items/53053ce806304fd71f06

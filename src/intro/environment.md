# やること

[ROS Wiki](http://wiki.ros.org/ROS/Tutorials) に準拠した内容で行います．  
ROSはOSのバージョンに合わせてインストールする必要があるので気をつけてください．  

今回の構成はいかのようにします．

| 項目 | 値 |
|:-:|:-:|
| 仮想環境 | VMware |
| OS | Ubuntu18.04 LTS |
| ROS Version | Melodic |


## **PC上にROSを扱える仮想環境を構築**

仮想環境については[このサイト](https://bcblog.sios.jp/what-is-virtualenvironment-vmware/)などを参照してください．


仮想環境の作り方は
[ROS講座54 VMWare上でROSを使う](https://qiita.com/srs/items/25efd45641c274bb8415)  
を参考にUbuntuの環境を作成してください．  
macの人は VMWare Fusion 12 Playerで試してみてください．
VMwareでうまくいかない人はVirtualBoxを使用してください．

## **ROSをインストール**

ROS Wiki は日本語ページも存在しますが，日本語版は古いものしか存在しないので，英語版を参照することをおすすめします．
- [日本語版](http://wiki.ros.org/ja/ROS/Tutorials)
- [英語版](http://wiki.ros.org/ROS/Tutorials)


ROSのインストールは[このサイト](http://wiki.ros.org/melodic/Installation/Ubuntu)に従って行います．

以下のコマンドを順番に実行して，ROSのインストールをしてください．  

```
sudo sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'

sudo apt-key adv --keyserver 'hkp://keyserver.ubuntu.com:80' --recv-key C1CF6E31E6BADE8868B172B4F42ED6FBAB17C654

sudo apt update

sudo apt upgrade

sudo apt install ros-melodic-desktop-full

echo "source /opt/ros/melodic/setup.bash" >> ~/.bashrc

source ~/.bashrc

sudo apt install python-rosdep python-rosinstall python-rosinstall-generator python-wstool build-essential

sudo rosdep init

rosdep update

mkdir -p ~/catkin_ws/src

cd ~/catkin_ws && catkin_make

echo "source ~/catkin_ws/devel/setup.bash" >> ~/.bashrc

source ~/.bashrc
```

端末を開いて`roscore`ができることを確認してください．  
`roscore`が正常に動作すればROS環境の構築完了です．

<br>

こまったとき(ROSが正常に作動しない，再インストールしたいときなど)  
は以下のコマンドでROS関連のパッケージを削除することができます．

```
sudo apt-get purge ros-melodic-*
```


## 課題

`roscore`の正常な動作を確認する（スクショを提出する？）

多分こんな文字が表示されると思う

```
... logging to ~/.ros/log/9cf88ce4-b14d-11df-8a75-00251148e8cf/roslaunch-machine_name-13039.log
Checking log directory for disk usage. This may take awhile.
Press Ctrl-C to interrupt
Done checking log file disk usage. Usage is <1GB.

started roslaunch server http://machine_name:33919/
ros_comm version 1.4.7

SUMMARY
========

PARAMETERS
 * /rosversion
 * /rosdistro

NODES

auto-starting new master
process[master]: started with pid [13054]
ROS_MASTER_URI=http://machine_name:11311/

setting /run_id to 9cf88ce4-b14d-11df-8a75-00251148e8cf
process[rosout-1]: started with pid [13067]
started core service [/rosout]
```
# ラズパイ4でROS Melodicをインストールする方法
本稿では，ラズベリーパイ4にROS Melodicをインストールする方法を紹介する．<br>
基本的には以下のURLを参考にしている．<br>
[ラズパイ4/BusterにROSのmelodicを入れる](https://qiita.com/Ninagawa_Izumi/items/063d9d4910a19e9fcdec)
<br>


## 実施環境
- ラズパイ4 4GB
- 16GB MicroSDカード

## ラズパイ4にROS Melodicをインストールする

こちらの単純に以下の順番に従って書いていけば良い．<br>
それぞれの詳細は，[参考URL](https://qiita.com/Ninagawa_Izumi/items/063d9d4910a19e9fcdec)を参照すること

```
sudo sh -c 'echo "deb  http://packages.ros.org/ros/ubuntu  $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'

sudo apt-key adv --keyserver 'hkp://keyserver.ubuntu.com:80' --recv-key C1CF6E31E6BADE8868B172B4F42ED6FBAB17C654

sudo apt-get update

sudo apt-get install -y python-rosdep python-rosinstall-generator python-wstool python-rosinstall build-essential  cmake

sudo rosdep init

rosdep update

mkdir ~/catkin_ws

cd ~/catkin_ws

rosinstall_generator desktop --rosdistro melodic --deps --wet-only --tar > melodic-desktop-wet.rosinstall

wstool init -j8 src melodic-desktop-wet.rosinstall

mkdir -p ~/catkin_ws/external_src

cd ~/catkin_ws/external_src

wget http://sourceforge.net/projects/assimp/files/assimp-3.1/assimp-3.1.1_no_test_models.zip/download -O assimp-3.1.1_no_test_models.zip

unzip assimp-3.1.1_no_test_models.zip

cd assimp-3.1.1

cmake .

make

sudo make install

sudo apt-get install  libogre-1.9-dev

cd ~/catkin_ws

rosdep install --from-paths src --ignore-src --rosdistro melodic -y

sudo ./src/catkin/bin/catkin_make_isolated --install -DCMAKE_BUILD_TYPE=Release --install-space /opt/ros/melodic -j2

echo "source /opt/ros/melodic/setup.bash" >> ~/.bashrc

sudo reboot
```

# ros1_bridgeの導入


## 導入環境

| OS | ROS version | ROS2 version |
|:-:|:-:|:-:|
| Ubuntu 20.04 | Noetic | Foxy |

<br>

## ROS1のパッケージをビルド

```
$ source /opt/ros/foxy/setup.bash
$ cd ~/catkin_ws
$ catkin_make
```

## ROS2のパッケージをビルド

```
$ source ~/catkin_ws/devel/setup.bash
$ cd ros2_ws/
$ colcon build
```

## ros1_bridgeのビルド

### パッケージの作成
```
$ mkdir -p ros1_bridge_ws/src
$ cd ~/ros1_bridge_ws/src
$ git clone -b foxy https://github.com/ros2/ros1_bridge.git
```

### ビルド

```
$ source /opt/ros/noetic/setup.bash
$ source /opt/ros/foxy/setup.bash
$ cd ~/ros1_bridge_ws
$ colcon build --symlink-install --packages-select ros1_bridge --cmake-force-configure
```
途中ROS_DISTRO was set to 'noetic' before. Please...という文が出るが問題なし。

## 実行

### ターミナルA

roscoreを立ち上げる。
```
$ source /opt/ros/noetic/setup.bash
$ roscore
```

### ターミナルB

ros1_bridgeを立ち上げる。
```
$ source /opt/ros/noetic/setup.bash
$ source /opt/ros/foxy/setup.bash
$ source ros1_bridge_ws/install/setup.bash
$ export ROS_MASTER_URI=http://localhost:11311
$ ros2 run ros1_bridge dynamic_bridge
```

### ターミナルC

ros1でtopicをpublishする。
```
$ source /opt/ros/noetic/setup.bash
$ rosrun rospy_tutorials talker
```

### ターミナルD

ros2でtopicをsubscribeする。
```
$ source /opt/ros/foxy/setup.bash
$ ros2 run demo_nodes_cpp listener
```

ターミナルCのROS1からpublishされたメッセージを、ターミナルDのROS2ノードでsubscribeしていることが確認できれば成功。<br>
publishとsubscribeを逆にすることも可能。

## 参考
[1]https://industrial-training-master.readthedocs.io/en/melodic/_source/session7/ROS1-ROS2-bridge.html
[2]https://qiita.com/kei_mo/items/c4c39bce051dd9dacc3c
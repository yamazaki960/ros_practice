# xArm7の使用手順

Moveitというライブラリを用いてアームを制御する。


## 1.諸々をインストール

以下のリンクから必要なパッケージをインストールする。
それぞれROSのバージョンに合わせたものをインストールする。

gazebo_ros_pkgs: http://gazebosim.org/tutorials?tut=ros_installing 
ros_control: http://wiki.ros.org/ros_control
moveit_core: https://moveit.ros.org/install/

xarmのパッケージをインストールする。

```
$ cd〜 / catkin_ws / src
$ git clone https://github.com/xArm-Developer/xarm_ros.git
```

他の依存パッケージをインストールする。
[kinetic]の部分はROSのバージョンによって書き換える。

```
$ rosdep update
$ rosdep check --from-paths . --ignore-src --rosdistro kinetic
```

不足している依存パッケージがあった場合、以下のコマンドでインストールする。

```
$ rosdep install --from-paths . --ignore-src --rosdistro kinetic -y
```


## 2.gazebo上で制御する

以下のコマンドでrvizとgezeboを用いてシミュレートできる。

専用のグリッパーを取り付けない場合：
```
$ roslaunch xarm_gazebo xarm7_beside_table.launch
```
別の端末で以下を実行。
```
$ roslaunch xarm7_moveit_config xarm7_moveit_gazebo.launch
```

専用のグリッパーを用いる場合：
```
$ roslaunch xarm_gazebo xarm7_beside_table.launch add_gripper：= true
```
別の端末で以下を実行。
```
$ roslaunch xarm7_gripper_moveit_config xarm7_gripper_moveit_gazebo.launch
```


## 3.実機を制御する

実機に接続する場合、最初にネットワークの設定を行う必要がある。

設定→ネットワーク設定→有線→オプション→IPv4設定

手動でIPv4アドレスを設定する。(アドレスは192.168.1.1〜192.168.1.255の範囲内であれば接続可能とあるが未確認)

| アドレス | ネットマスク | ゲートウェイ |
|:-:|:-:|:-:|
| 192.168.1.12 | 255.255.255.0 | 192.168.1.1 |

変更して保存。

その後以下のコマンドを実行する。
[robot_ip：=]以降の数字はコントロールボックスに記載してあるLANIPアドレスを記入する。
現在研究室で所有しているものは[192.168.1.211]である。

```
$ roslaunch xarm7_moveit_config realMove_exec.launch robot_ip：= 192.168.1.211
```

専用のグリッパーを用いる場合は以下のコマンドで実行する。

```
$ roslaunch xarm7_gripper_moveit_config realMove_exec.launch robot_ip：= 192.168.1.211
```


## 4.終了の仕方

xarmの電源を落とす際は次の手順で行う。

1.非常停止ボタンを押す
2.コントロールボックスの停止ボタン(LANケーブル挿入口の近く)を5秒間押し、隣のランプが消えるのを確認する
3.off/onスイッチを押し、電源プラグを抜く


## 参考

http://wiki.ros.org/xarm

https://cdn.shopify.com/s/files/1/0012/6979/2886/files/xArm_User_Manual-V1.6.9.pdf?v=1618883794

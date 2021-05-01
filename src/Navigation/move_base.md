# move_baseによるナビゲーション
ROSパッケージのmove_baseによって経路計画や追従，障害物回避を行なうことができます。 

## move_baseについて

## 動作確認
### <u>環境</u>
| PC | RAM | OS | ROS version |
|:-:|:-:|:-:|:-:|
| mouse-pc（古いパソコン） | 32 GB | Ubuntu 16.04 | Kinetic |

<br>

### <u>Install</u>
**apt installの場合(推奨)**  
以下のコマンドで必要なパッケージが全て入るかは不明。誰か試してみてください
```  
$ sudo apt-get install ros-$ROS_DISTRO-move-base
```  
**git cloneの場合**  
以下のコマンドのとおり。ビルドの順番に注意。まとめてやらない。
```
$ cd ~/catkin_ws/src
$ git clone https://github.com/ros-planning/navigation.git
$ cd ..
$ catkin_make --pkg costmap_2d
$ catkin_make
```
<span style="color:red;">注意(Melodic以前)</span>
- githubから最新のパッケージをインストールするとビルドでエラー  
→ 古いバージョンをインストールする。代わりに以下のコマンドでインストール。[参考](https://qiita.com/iaoiui/items/fc318fa75cce3227b638)  

Melodic
```
$ git clone https://github.com/ros-planning/navigation.git -b 1.16.7 --depth 1 
```
Kinetic (Melodicのものでも動くはずだが一応)
```
$ git clone https://github.com/ros-planning/navigation.git -b 1.14.9 --depth 1 
```

### <u>実行</u>
move_baseは複数のパラメータファイルを実行時に読み込む必要があるため，基本はlaunchで実行する。各パラメータファイルの書き方については[こちら](./param_file.md)

**launchファイル**
```XML
<?xml version="1.0" encoding="UTF-8"?>
<launch>
    <!-- move_base -->
    <node pkg="move_base" type="move_base" respawn="false" name="move_base" output="screen">
      <rosparam file="$(find {ymalファイルのあるパッケージ名})/config/move_base.yaml" command="load" />
	  <rosparam file="$(find {ymalファイルのあるパッケージ名})/config/costmap_common.yaml" command="load" ns="global_costmap" />
	  <rosparam file="$(find {ymalファイルのあるパッケージ名})/config/costmap_common.yaml" command="load" ns="local_costmap" />
	  <rosparam file="$(find {ymalファイルのあるパッケージ名})/config/costmap_local.yaml" command="load" />
	  <rosparam file="$(find {ymalファイルのあるパッケージ名})/config/costmap_global.yaml" command="load" />
	  <rosparam file="$(find {ymalファイルのあるパッケージ名})/config/planner.yaml" command="load" />

      <!-- move_baseのパラメーラはここでも変更できる
	  <remap from="/cmd_vel" to="/ypspur_ros/cmd_vel" />
      -->
    </node>
 
</launch>
```
<br>

## 参考
[ROS Wiki Navigation](http://wiki.ros.org/navigation?distro=melodic)  
[Gitで特定のブランチorタグをcloneする](https://qiita.com/iaoiui/items/fc318fa75cce3227b638)
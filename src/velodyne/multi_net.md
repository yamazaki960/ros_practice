# Velodyneの複数接続（ネット編） 

ネットを介してVLP16を接続しよう

## launchファイルを書く

以下のものを書きます．終わりです．  
任意にパラメータは書き換えてください．
```
<launch>

<arg name="velodyne_calib" default="$(find velodyne_pointcloud)/params/VLP16db.yaml"/>

<group ns="vlp_1">

    <include file="$(find velodyne_pointcloud)/launch/VLP16_points.launch">
      <arg name="calibration" value="$(arg velodyne_calib)"/>
      <arg name="device_ip" value=""/>
      <arg name="frame_id" value="velodyne1"/>
      <arg name="port" value="2368"/>
    </include>

</group>

</launch>
```

~/.bashrcにマスター側のIPアドレスと自分のIPを設定する
例）マスター側のIP 192.168.11.100で，サブの側が192.168.11.101の場合
```
export ROS_MASTER_URI=http://192.168.11.100:11311
export ROS_IP=192.168.11.101
```
書き終わったら，以下を実行
```
source ~/.bashrc
```

次に，/etc/hostsを追加する．  
多分ある程度書いてあるので，以下の文を追加する  
例）マスター側のホスト名がHostNameで，IPが192.168.11.100の場合  
```
192.168.11.100 HostName
```
サブ同士で通信するときも，それぞれホスト名を書き加える  
例）サブ側のホスト名がHostNameSubで，IPが192.168.11.101の場合  
```
192.168.11.101 HostNameSub
```

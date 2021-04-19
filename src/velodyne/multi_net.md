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
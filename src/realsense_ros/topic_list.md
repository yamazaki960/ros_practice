# ROSのRealSenseパッケージ(`realsense2_camera`)で扱うトピックについて


## rosbagで保存する場合の注意点

RealSenseでrosbagを保存する場合，realsenseの全トピックを選択するとエラーが発生する．
とりあえず応急処置として，以下のトピックを保存すれば必要最低限となるのでメモ

```bash
rosbag record /camera/color/camera_info /camera/color/image_raw /camera/depth/camera_info /camera/depth/color/points /camera/depth/image_rect_raw /camera/extrinsics/depth_to_color /tf /tf_static /velodyne_points /camera/accel/sample -O <bagfile_name>.bag
```

## 参考
- [intel realsense ROS & ROS2](https://dev.intelrealsense.com/docs/ros-wrapper)
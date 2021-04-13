# realsenseのimuのデータ取得

realsense-viewerの2d表示とmotion moduleでaccelというのを見ると，realsenseの姿勢を表示していることが確認できる．  
姿勢の取得方法についてメモ．

## 前提条件

rosでrealsenseが使える状態になっている．

使用したrealsense
- Intel RealSense LiDAR Camera l515

## やり方

1. realsenseをrealsense2_cameraで起動する．  
起動方法は`roslaunch realsense2_camera demo_pointcloud.launch`  
(ただし，`<arg name="enable_accel" value="false"/>`を`<arg name="enable_accel" value="true"/>`に変更)
2. 起動したあとに，こんな感じのスクリプトを実行する（あくまでも一例）
```python
#!/usr/bin/env python
import rospy

from sensor_msgs.msg import Imu as msg_Imu
import math

def callback(data):
    accel = data.linear_acceleration   
    
def listener():

    # in ROS, nodes are unique named. If two nodes with the same
    # node are launched, the previous one is kicked off. The 
    # anonymous=True flag means that rospy will choose a unique
    # name for our 'listener' node so that multiple listeners can
    # run simultaenously.
    rospy.init_node('listener', anonymous=True)

    rospy.Subscriber("/camera/accel/sample", msg_Imu, callback)

    # spin() simply keeps python from exiting until this node is stopped
    rospy.spin()
        
if __name__ == '__main__':
    listener()
```
取得したimuの個別の値を抽出する方法は`realsense2_camera/scripts/rs2_listener.py`の`callback(self, data)`を見るとなんとなくわかる．


## 参考
- [IMUからのトピックをTFに変換する](https://qiita.com/shrimp-f/items/6c6820b88f162731dd94)
- [Writing a tf2 static broadcaster (Python)](http://wiki.ros.org/tf2/Tutorials/Writing%20a%20tf2%20static%20broadcaster%20%28Python%29)
- [realsense_camera](http://wiki.ros.org/realsense_camera)
- [rviz_imu_plugin](http://wiki.ros.org/rviz_imu_plugin)
- [３軸加速度センサを用いた姿勢推定](https://watako-lab.com/2019/02/15/3axis_acc/)
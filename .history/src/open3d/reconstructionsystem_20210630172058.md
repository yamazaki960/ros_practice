# 自分で取得したデータでreconstructionsystemの実行

## 注意

   この章を実行するには、すでにrealsenseを実装し使えるようになっている必要があります。

   [realsenseの実装方法](src/realsense_ros/index.md)
## 実行方法

1. 取得した画像を保存するファイルを作成

   サンプルコードを実行したときと同じように`examples/python/reconstruction_system/config`の中に新しいファイルを作成する。

2. コードのpathを書き直す

   ソースコード内の`examples/python/reconstruction_system/config`の中にあるrealsense.jsonを開く

   3行目のpath_datasetはサンプルコードと同じように`config/{画像を保存するファイル名}`と書き直す

   4行目のpath_intrinsicは`config/realsense/camera_intrinsic.json`と書き直す

```
   {
       "name": "Realsense bag file",
       "path_dataset": "dataset/{画像を保存するファイル名}/",
       "path_intrinsic": "config/realsense/camera_intrinsic.json",
       "max_depth": 3.0,
       "voxel_size": 0.05,
       "max_depth_diff": 0.07,
       "preference_loop_closure_odometry": 0.1,
       "preference_loop_closure_registration": 5.0,
       "tsdf_cubic_size": 3.0,
       "icp_method": "color",
       "global_registration": "ransac",
       "python_multi_threading": true
   }
```

3. realsenseで画像の取得　

   3Dモデル化したい物体の周囲をぐるぐる回って取得する。

   `$ python realsense_recorder.py --record_imgs`

4. reconstructionsystemの実行

   `$ python run_system.py config_file --make --register --refine --integrate`

   ※config_fileの部分は`config/realsense.json`に書き換える
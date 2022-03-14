# 自分で取得したデータでreconstructionsystemの実行

## 実行環境

   Ubuntu20.04(noetic)

## 注意

   この章を実行するには、realsense、anacondaを実装し、opencv,pyreslsense2のインストールをしておく必要があります。

   [realsenseの実装方法](https://github.com/tomson784/ros_practice/blob/main/src/realsense_ros/index.md)

   [anacondaの実装方法](https://www.pc-koubou.jp/magazine/38846)

   opencvのインストール　`$ pip install opencv-python`

   pyrealsense2のインストール　`$ pip install pyrealsense2`

## インストール方法

open3dはpython3で動作する.

```sh
sudo apt-get install open3d
pip3 install opencv-python
pip3 install pyrealsense2
```

reconstraction_systemを使うために、以下のgithubをクローンする．

```sh
cd ~
git clone https://github.com/isl-org/Open3D
```

## 実行方法

1. 使用するファイル構成
   
   以下のPathにreconstruction_systemのフォルダがある．
   ```sh
   cd ~/Open3D/examples/python/reconstruction_system
   ```
   使うファイルは以下の3つである
   - **config/realsense.json** : reconstruction_systemを実行する際に必要なパラメータファイル(*.json)がある
   - **scripts/realsense_recorder.py** : Realsenseで色+深度画像を収集するスクリプト
   - **run_system.py.py** : reconstruction_systemを実行するスクリプト

2. 色+深度画像の収集

   以下を実行すると、dataset/realsenseというフォルダが新たに生成され、そこにデータが取得される．  
   --output_folderによって、出力パスを決めることも出来る．
   ```sh
   cd ~/Open3D/examples/python/reconstruction_system/scripts
   python3 scripts/realsense_recorder.py --record_imgs --output_folder ../dataset/realsense/
   ```

3. パラメータファイルの変更

   realsense.jsonを開く
   ```sh
   sudo gedit /Open3D/examples/python/reconstruction_system/config/realsense.json
   ```
   以下のように修正する  
   - **"path_dataset"** : 先程収集した画像データのフォルダパス
   - **"path_intrinsic"** : 先程収集した画像データのフォルダパスに生成されたjsonパス
   ```json
   {
       "name": "Realsense bag file",
       "path_dataset": "dataset/realsense",
       "path_intrinsic": "dataset/realsense/camera_intrinsic.json",
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
   
4. reconstruction_systemの実行

   以下を実行する、割と時間がかかる．
   ```sh
   cd ~/Open3D/examples/python/reconstruction_system
   python3 run_system.py config/realsense.json --make --register --refine --integrate
   ```
   
   生成された3Dモデルは、画像データフォルダと同じ"dataset/realsense/scene"の中にある.   
   integrated.plyという名称で生成されている．
   
## トラブルシューティング

### **Realsenseで取得した画像の色がおかしい**  
ubuntu 20.04LTS + noeticで動作したときに、エラーはでないものの画像の色が実際の色と違うことがあった．  
なぜか、RGB形式に治っていないようなので、以下のように該当部分を追加修正する．
```py
   color_image = np.asanyarray(color_frame.get_data())
   color_image = cv2.cvtColor(color_image, cv2.COLOR_BGR2RGB)
```

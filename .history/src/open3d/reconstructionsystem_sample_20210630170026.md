# resonstructionsystem

realsenseによって取得した点群画像から3D画像を再構築することができる。

[参考にしたサイト](http://www.open3d.org/docs/release/tutorial/reconstruction_system/index.html)

## サンプルコードの実行

1. 使用する画像(016)のダウンロード先

https://drive.google.com/file/d/11U8jEDYKvB5lXsK3L1rQcGTjp0YmRrzT/view

2. 画像を入れておくファイルの作成

先程ダウンロードした画像016を、ソースコード内の`examples/python/reconstruction_system/config`の中に新しいファイル（例：dataset）を作成し、その中に移動させる。

3. コードのpathを書き直す

ソースコード内の`examples/python/reconstruction_system/config`の中にあるturorial.jsonを開く

3行目のpath_datasetがクローンしたままの状態だと、`dataset/tutorial/`となっているので正しく書き直す

2でファイルの名前を例と同じようにした場合、下記のように書き換えると良い。（違う名前にした場合は、datasetの部分をその名前に変える）
```
{
    "name": "Open3D reconstruction tutorial http://open3d.org/docs/release/tutorial/reconstruction_system/system_overview.html",
    "path_dataset": "config/dataset/016/",
    "path_intrinsic": "",
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

4. コードを実行

`$ python run_system.py config_file --make --register --refine --integrate`

※config_fileの部分は`config/tutorial.json`に書き換える


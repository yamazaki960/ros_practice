# パラメータファイルの書き方
move_base実行時に必要なパラメータについてのメモ。(move_baseについては[こちら](./move_base.md))

パラメータとして，だいたい次の設定ファイルが必要。名前はなんでもいい。
- costmap_common.yaml：グローバルとローカルコストマップのパラメータ，2つに共通するものを書く。
- costmap_global.yaml：グローバルコストマップのパラメータ
- costmap_local.yaml：ローカルコストマップのパラメータ
- planner.yaml：グローバル・ローカルプランナーのパラメータ，それぞれ設定ファイルを分けてもよい。
- move_base.yaml：move_baseのパラメータ，直接launchファイルに書いても良い．

<br>

## 作成方法
以下の内容のyamlファイルを作成する。  

<u>costmap_common.yaml</u>

```py
obstacle_range: 2.5   
raytrace_range: 3.0   
footprint: [[0.20, 0.22], [-0.20, 0.22], [-0.20, -0.22], [0.20, -0.22]] 
#robot_radius: ir_of_robot

robot_base_frame: base_link 

update_frequency: 1.0    
publish_frequency: 1.0  
transform_tolerance: 0.5 　

unknown_cost_value: -1      
```

<details><summary> パラメータ説明(common) </summary>
このパラメータをglobal,localにそれぞれ記述しても同じ<br>
追記予定
<!--
obstacle_range: 2.5   # ロボットとの距離がobstacle_range以下のオブジェクトは障害物としてみなし、コストマップに反映
raytrace_range: 3.0   # ロボットとの距離がraytrace_range以下でオブジェクトが検出された場合、そのオブジェクトの内側のコストマップの障害物をクリア
footprint: [[0.20, 0.22], [-0.20, 0.22], [-0.20, -0.22], [0.20, -0.22]] # ロボットの形状を多角形で指示する
#robot_radius: ir_of_robot

robot_base_frame: base_link # ロボットの座標フレーム

update_frequency: 1.0       # costmapを更新する頻度。（Hz）
publish_frequency: 1.0      # costmapの配信頻度 0.0
transform_tolerance: 0.5 　　 #　tfの遅延に対する待ち時間 これを超えるとロボット停止

unknown_cost_value: -1      #  マップサーバーからマップを読み取るときに、コストが不明であると見なされる値
--><!---->
</details>

<br>

<u>costmap_global.yaml</u>

```py
global_costmap:
  global_frame: map
  robot_base_frame: base_link
  update_frequency: 1.0
  publish_frequency: 1.0
  static_map: false
  width: 10
  height: 10

  plugins:
   - {name: static_layer, type: "costmap_2d::StaticLayer"}
   - {name: obstacle_layer, type: "costmap_2d::ObstacleLayer"}
   - {name: inflation_layer, type: "costmap_2d::InflationLayer"}
  static_layer:
    track_unknown_space: true
    subscribe_to_updates: true
    unknown_cost_value: 255
  obstacle_layer:
    observation_sources: laser
    laser: {topic: scan, data_type: LaserScan, expected_update_rate: 3.0, observation_persistence: 0.0, marking: true, clearing: true, inf_is_valid: false}
  inflation_layer:
     inflation_radius: 0.6
     cost_scaling_factor: 2.5
```
<u>costmap_local.yaml</u>

```py
local_costmap:
  global_frame: odom
  robot_base_frame: base_link
  update_frequency: 2.0
  publish_frequency: 1.0
  static_map: false
  rolling_window: true
  width: 3.0
  height: 3.0
  resolution: 0.05
  plugins:
   - {name: obstacle_layer, type: "costmap_2d::ObstacleLayer"}
   - {name: inflation_layer, type: "costmap_2d::InflationLayer"}
  obstacle_layer:
    observation_sources: laser
    laser: {topic: scan, data_type: LaserScan, expected_update_rate: 3.0, observation_persistence: 0.0, marking: true, clearing: true, inf_is_valid: false}
  inflation_layer:
     inflation_radius: 0.6
     cost_scaling_factor: 2.5
```

<details><summary> パラメータ説明(global,local) </summary>
パラメータの種類はglobal,localともに同じ<br>
追記予定
<!--
global_frame: map            # global cost map の実行フレーム
#   rolling_window: false       # ロボットが世界を移動しても、コストマップはロボットを中心に維持
   static_map: true             # mapが静的か
   resolution: 0.05             # コストマップの解像度 [m/pixel]  マップと同じにしとくと良い(delta)
   plugins:
   - {name: static_layer, type: "costmap_2d::StaticLayer"}             # 静的マップを使用する場合
   - {name: obstacle_layer, type: "costmap_2d::ObstacleLayer"}   # センサからの障害物層
   - {name: inflation_layer, type: "costmap_2d::InflationLayer"}  #
    
   static_layer:
     map_topic : map
     track_unknown_space : true   # unknown領域の扱い。trueならunknown領域、falseならfree領域
     unknown_cost_value : -1     # マップを読み取るときに、コストが不明であると見なされる値  -1 == 255
     subscribe_to_updates: false    # map_updateトピックを受け入れるか default false
     lethal_cost_threshold ：100          # マップを読み取るときに致命的なコストとするしきい値
     # その他3つくらい
   obstacle_layer:
     track_unknown_space: false   # unknown領域の扱い。trueならunknown領域、falseならfree領域
     max_obstacle_height:2.0  # 有効センサ読み取り最大高さ[m]。
     obstacle_range:2.5  # コストマップに障害物を挿入する最大範囲[m]
     raytrace_range:3.0 # マップから障害物をレイトレーシングする最大範囲[m]
     footprint_clearing_enabled:true  # ロボットのフットプリントが移動するスペースをクリア．
     # voxelCostmap　3次元追跡用
     origin_z：0.0　# マップのz原点
     z_resolution：0.2
     z_voxels：10 # 各垂直列のボクセルの数
     unknown_threshold:z_voxels  # 「既知」と見なされる列で許可される未知のセルの数
     mark_threshold：0  # 「空き」と見なされる列で許可されるマークされたセルの最大数
     publish_voxel_map：false # ボクセルグリッドを公開するか
     footprint_clearing_enabled：true
     observation_sources: <source_name>      # センサ情報の名前空間を指定
     <source_name>:
       sensor_frame: “”                  # センサのフレーム,
       data_type: PointCloud          # データタイプ
       topic: source_name                # センサのトピック
       expected_update_rate: 0.0     # センサー読み取り期待頻度。0.0は制限なし．センサの実際のレートよりもわずかに許容度の高い値に設定．
       observation_persistence: 0.0  # センサーの読み取り値保持時間
       marking: true                 # センサデータを障害物としてコストマップに反映させるか
       clearing: false                # センサデータを障害物のクリアに使うか 2dlidarを使用する際には注意
       max_obstacle_height：2.0    # globalのmax_obstacle_heightより小さい
       min_obstacle_height：0.0   # 有効センサ読み取り最小高さ[m]。通常、地面の高さに設定
       obstacle_range：2.5
       raytrace_range：3.0
       inf_is_valid: false            # LaserScanで inf値を使用するか．最大範囲に変換．
   inflation_layer:
     inflation_radius: 1.0       #　ロボットが障害物にぶつからないようにするための膨張パラメータ
     cost_scaling_factor: 2.5
--><!---->
</details>

<br>

<u>planner.yaml</u>

```py
GlobalPlaner:
  allow_unknown: true
  Visualize_potential: true

DWAPlannerROS:
  acc_lim_x: 2.0
  acc_lim_y: 0.0
  acc_lim_th: 2.5

  max_trans_vel: 0.2
  min_trans_vel: 0.05

  max_vel_x: 0.2
  min_vel_x: -0.05
  max_vel_y: 0.0
  min_vel_y: 0.0
  max_rot_vel: 0.8
  min_rot_vel: 0.2

  yaw_goal_tolerance: 0.2
  xy_goal_tolerance: 0.13
  latch_xy_goal_tolerance: true

  sim_time: 2.0
  sim_granularity: 0.025
  vx_samples: 4
  vtheta_samples: 10

```
<details><summary> パラメータ説明(planner) </summary>
追記予定
</details>

<br>

<u>move_base.yaml</u>

```py
base_global_planner: "global_planner/GlobalPlanner"
base_local_planner: "dwa_local_planner/DWAPlannerROS"

shutdown_costmaps: true

planner_frequency: 0.2

controller_frequency: 2.0
recovery_behaviour_enabled: true
clearing_rotation_allowed: false

oscillation_timeout: 2.0
oscillation_distance: 0.5
```
<details><summary> パラメータ説明(move_base) </summary>
追記予定
</details>
<br>

## 参考


## **ROSの基本的なデータの受け渡し**

ROSのパッケージを作成して，Publisher，Subscriberを実行する．

| 順番 | 日本語URL | 英語URL |
|:-:|:-:|:-:|
|1| [ROSパッケージを作る](http://wiki.ros.org/ja/ROS/Tutorials/CreatingPackage) | [Creating a ROS Package](http://wiki.ros.org/ROS/Tutorials/CreatingPackage) |
|2| [ROSのパッケージをビルドする](http://wiki.ros.org/ja/ROS/Tutorials/BuildingPackages) | [Building a ROS Package](http://wiki.ros.org/ROS/Tutorials/BuildingPackages) |
|3| [シンプルな配信者(Publisher)と購読者(Subscriber)を書く(C++)](http://wiki.ros.org/ja/ROS/Tutorials/WritingPublisherSubscriber%28c%2B%2B%29) | [Writing a Simple Publisher and Subscriber (C++)](http://wiki.ros.org/ROS/Tutorials/WritingPublisherSubscriber%28c%2B%2B%29) |
|4| [シンプルな配信者(Publisher)と購読者(Subscriber)を書く(Python)](http://wiki.ros.org/ja/ROS/Tutorials/WritingPublisherSubscriber%28python%29) | [Writing a Simple Publisher and Subscriber (Python)](http://wiki.ros.org/ROS/Tutorials/WritingPublisherSubscriber%28python%29) |
|5| [シンプルなPublisherとSubscriberを実行してみる](http://wiki.ros.org/ja/ROS/Tutorials/ExaminingPublisherSubscriber) | [Examining the Simple Publisher and Subscriber](http://wiki.ros.org/ROS/Tutorials/ExaminingPublisherSubscriber) |

#### 課題 2
Terminal上に以下の文字列が表示されるか確認（スクショ？未定）
```
[ INFO] 1251943144.400553000: Received [Hello there! This is message [1]]
[ INFO] 1251943144.600712000: Received [Hello there! This is message [2]]
[ INFO] 1251943144.801003000: Received [Hello there! This is message [3]]
        :
        :
        :
```

## **ROSに流れてくるデータの保存**

[データを記録し，リプレイをする](http://wiki.ros.org/ja/ROS/Tutorials/Recording%20and%20playing%20back%20data)  

#### 課題 3

turtlesimがrosbagで動いていることを確認

## **ROSを使ったArduinoの制御**

ROSを用いたArduino制御の[チュートリアルのリスト](http://wiki.ros.org/rosserial_arduino/Tutorials)  

やってもらいたい項目
1. [Arduino IDE Setup](http://wiki.ros.org/rosserial_arduino/Tutorials/Arduino%20IDE%20Setup)
2. [Hello World (example publisher)](http://wiki.ros.org/rosserial_arduino/Tutorials/Hello%20World)
3. [Blink (example subscriber)](http://wiki.ros.org/rosserial_arduino/Tutorials/Blink)

仮想環境とホストPCでArduinoのシリアルポートを共有する方法については
[ここ](http://kazuki-room.com/how_to_connect_to_the_vmware_serial_port/)
を参照

#### 課題 4

`rqt_graph`などでノードが繋がっているか確認してもらう．

## **その他**

### 応用

ROSの強みはインターネット上のフリーのパッケージを用いることで，手軽に高度なアルゴリズムを実装できる点にあります．  
[Industrial Training](https://industrial-training-jp.readthedocs.io/ja/latest/index.html)のサイトに様々なパッケージの紹介と使い方についての説明があるので，基本的なことができるようなった人はやってみてください．

### デュアルブート(Nvidia GPU あり)
デュアルブートで躓いている人が多い印象だったので，自分が参考にしたサイトのURLを載せておきます．  
[【上級者向け】Ubuntuをデュアルブートする《その１：既にWindowsが入っているSSD・HDDにUbuntuを入れる》](https://guminote.sakura.ne.jp/archives/233)  
[【Ubuntu】NVIDIAドライバ・CUDA・CUDNNをインストールして深層学習環境を整える](https://guminote.sakura.ne.jp/archives/328)  
このサイトの方法に従ってやったら，GPUが認識されました．使用したPCはGALLERIAです．

### Docker
Dockerを用いればROSを試す環境を簡単に構築することができます．  
興味があれば以下のYoutubeを見てください．  
[ロボットシステム学第12回（Docker）](https://www.youtube.com/watch?v=Utvf4YmMJpk&list=PLbUh9y6MXvjdIB5A9uhrZVrhAaXc61Pzz&index=16)  
サンプルを[ここ](https://github.com/tomson784/ros_tutorial)に用意しました．

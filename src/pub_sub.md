# ROSの基本的なデータの受け渡し

ROSのパッケージを作成して，Publisher，Subscriberを実行する．

| 順番 | 日本語URL | 英語URL |
|:-:|:-:|:-:|
|1| [ROSパッケージを作る](http://wiki.ros.org/ja/ROS/Tutorials/CreatingPackage) | [Creating a ROS Package](http://wiki.ros.org/ROS/Tutorials/CreatingPackage) |
|2| [ROSのパッケージをビルドする](http://wiki.ros.org/ja/ROS/Tutorials/BuildingPackages) | [Building a ROS Package](http://wiki.ros.org/ROS/Tutorials/BuildingPackages) |
|3| [シンプルな配信者(Publisher)と購読者(Subscriber)を書く(C++)](http://wiki.ros.org/ja/ROS/Tutorials/WritingPublisherSubscriber%28c%2B%2B%29) | [Writing a Simple Publisher and Subscriber (C++)](http://wiki.ros.org/ROS/Tutorials/WritingPublisherSubscriber%28c%2B%2B%29) |
|4| [シンプルな配信者(Publisher)と購読者(Subscriber)を書く(Python)](http://wiki.ros.org/ja/ROS/Tutorials/WritingPublisherSubscriber%28python%29) | [Writing a Simple Publisher and Subscriber (Python)](http://wiki.ros.org/ROS/Tutorials/WritingPublisherSubscriber%28python%29) |
|5| [シンプルなPublisherとSubscriberを実行してみる](http://wiki.ros.org/ja/ROS/Tutorials/ExaminingPublisherSubscriber) | [Examining the Simple Publisher and Subscriber](http://wiki.ros.org/ROS/Tutorials/ExaminingPublisherSubscriber) |

## 課題

Terminal上に以下の文字列が表示されるか確認（スクショ？未定）

```
[ INFO] 1251943144.400553000: Received [Hello there! This is message [1]]
[ INFO] 1251943144.600712000: Received [Hello there! This is message [2]]
[ INFO] 1251943144.801003000: Received [Hello there! This is message [3]]
        :
        :
        :
```

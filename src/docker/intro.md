# Dockerについて

ホスト上にホスト環境とは別のOS環境を構築することができる．  

VirtualBoxなどのようにOS環境をエミュレーションするのではなく，Linuxのプロセス隔離の機能を使ってOS環境を再現するもの．

ホストOSのカーネルを使用しているので，通常だとホストOSがLinuxならLinux系列のOSのみ動かすことができる．
また，DockerコンテナのOSがホストOSで使用されるカーネルよりも新しいものだと正常に動作しない可能性がある．
カーネルは後方互換性はあるのでホストOSが最新に近いものであればあまり問題は発生しない．

ここまでの説明は大雑把なものであり，正確な内容を理解したい方は公式サイトなどを参照してください．

## 参考
- [ロボットシステム学第12回（Docker）](https://www.youtube.com/watch?v=Utvf4YmMJpk&list=PLbUh9y6MXvjdIB5A9uhrZVrhAaXc61Pzz&index=17)
- [Docker (software)  Wikipedia](https://en.wikipedia.org/wiki/Docker_(software))

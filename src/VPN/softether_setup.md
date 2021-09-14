# SoftEther VPN Clientのセットアップ
MacおよびLinuxでのSoftEther VPNを利用するための手順

## SoftEther VPN Clientのインストール
MacおよびLinuxのどちらも基本的な手順は同じ。手順は以下のとおり。

- [事前準備(Macのみ)](#事前準備)
- [Clientのインストール](#Clientのインストール)
- [Clientの起動(Mac,Linuxで異なる)](#Clientの起動)

### 事前準備
***
Macのみ以下の二つが必要。ただし，もともと入っている可能性がある？あとからでいいかも。
1. XcodeのCommand Line Toolsをインストール
2. TunTapをインストール

<br>

### Clientのインストール
***
1. [SoftEther ダウンロードセンター](https://www.softether-download.com/ja.aspx?product=softether)からSoftEather Clientをダウンロード

2. 解凍する。コマンドの場合は以下
```
$ tar xvf softether-vpnclient-{version}.tar.gz
```

3. vpnclientというフォルダへ移動して `make`  
ライセンスの同意を求められるのですべて`1`と入力

4. ビルドされたvpnclientフォルダを/usr/localに移動
```
$ cd ../
$ sudo mv vpnclient /usr/local/
```

5. パーミッション変更
```
$ cd /usr/local
$ sudo chown -R root:root vpnclient
$ cd vpnclient
$ sudo chmod 600 *
$ sudo chmod 700 vpncmd
$ sudo chmod 700 vpnclient
```

6. vpncmd の check コマンドによる動作チェック
``` 
$ cd vpnclient
$ sudo ./vpncmd
vpncmd コマンド - SoftEther VPN コマンドライン管理ユーティリティ
SoftEther VPN コマンドライン管理ユーティリティ (vpncmd コマンド)
Version 4.34 Build 9745   (Japanese)
Compiled 2020/04/05 23:39:56 by buildsan at crosswin
Copyright (c) SoftEther VPN Project. All Rights Reserved.

vpncmd プログラムを使って以下のことができます。

1. VPN Server または VPN Bridge の管理
2. VPN Client の管理
3. VPN Tools コマンドの使用 (証明書作成や通信速度測定)

1 - 3 を選択: 3

VPN Tools を起動しました。HELP と入力すると、使用できるコマンド一覧が表示できます。

VPN Tools>check
Check コマンド - SoftEther VPN の動作が可能かどうかチェックする
---------------------------------------------------
SoftEther VPN 動作環境チェックツール

Copyright (c) SoftEther VPN Project.
All Rights Reserved.

この動作環境チェックツールを実行したシステムがテストに合格した場合は、SoftEther VPN ソフトウェアが動作する可能性が高いです。チェックにはしばらく時間がかかる場合があります。そのままお待ちください...

'カーネル系' のチェック中...
              [合格] ○
'メモリ操作系' のチェック中...
              [合格] ○
'ANSI / Unicode 文字列処理系' のチェック中...
              [合格] ○
'ファイルシステム' のチェック中...
              [合格] ○
'スレッド処理システム' のチェック中...
              [合格] ○
'ネットワークシステム' のチェック中...
              [合格] ○

すべてのチェックに合格しました。このシステム上で SoftEther VPN Server / Bridge が正しく動作する可能性が高いと思われます。

コマンドは正常に終了しました。
```

### Clientの起動
***
<u>Mac</u>  
以下で起動
```
$ sudo ./vpnclient start
```

<u>Linux</u>  
Clientをsystemdサービスへ登録し，自動起動設定を行う。  

1. vpnclient.serviceファイルを作成
```
$ sudo vim /etc/systemd/system/vpnclient.service
```
&emsp;&emsp;&emsp;以下のように記述
```
[Unit]
Description=SoftEther VPN Client
After=network.target network-online.target

[Service]
ExecStart=/usr/local/vpnclient/vpnclient start
ExecStop=/usr/local/vpnclient/vpnclient stop
Type=forking
RestartSec=3s

[Install]
WantedBy=multi-user.target
```

2. systemctlコマンドでサービスの開始と有効化
```
$ sudo systemctl start vpnclient
$ sudo systemctl enable vpnclient
```

3. `active(running)`と表示されていることを確認
```
$ sudo systemctl status vpnclient
```

4. 再起動後にサービスが有効になっているか確認
```
$ systemctl list-unit-files --type=service | grep vpn
```

<br>

## SoftEther VPN Clientの設定
Mac,Linux共通。CUIによって設定する。コマンド一覧は[[2]](https://ja.softether.org/4-docs/1-manual/6/6.5)

1. VPN Clientへの接続
```
$ cd /usr/local/vpnclient
$ sudo ./vpncmd
vpncmd コマンド - SoftEther VPN コマンドライン管理ユーティリティ
SoftEther VPN コマンドライン管理ユーティリティ (vpncmd コマンド)
Version 4.34 Build 9745   (Japanese)
Compiled 2020/04/05 23:39:56 by buildsan at crosswin
Copyright (c) SoftEther VPN Project. All Rights Reserved.

vpncmd プログラムを使って以下のことができます。

1. VPN Server または VPN Bridge の管理
2. VPN Client の管理
3. VPN Tools コマンドの使用 (証明書作成や通信速度測定)

1 - 3 を選択: 2

接続先の VPN Client が動作しているコンピュータの IP アドレスまたはホスト名を指定してください。
何も入力せずに Enter を押すと、localhost (このコンピュータ) に接続します。
接続先のホスト名または IP アドレス: 

VPN Client "localhost" に接続しました。

VPN Client>
```

2. 仮想LANカードの作成,有効化(LANカード名はなんでも)
```
VPN Client>NicCreate lan_vnic
VPN Client>NicEnable {先程設定したLANカード名}
```

3. 接続設定の作成
```
VPN Client>AccountCreate
AccountCreate コマンド - 新しい接続設定の作成
接続設定の名前: vpn_to_lab

接続先 VPN Server のホスト名とポート番号: {ホスト名:ポート番号}

接続先仮想 HUB 名: {HUB名}

接続するユーザー名: {ユーザ名}

使用する仮想 LAN カード名: {2で設定したもの}

コマンドは正常に終了しました。
```

4. パスワード認証の設定
```
VPN Client>AccountPasswordSet
```

## 参考
[1] [筑波大学大学院研究プロジェクト SoftEther VPN](https://ja.softether.org/)  
[2] [6.5 VPN Client の管理コマンドリファレンス](https://ja.softether.org/4-docs/1-manual/6/6.5)  
[3] [MacでSoftEther VPN Clientを使う](https://qiita.com/ask/items/9ff1529d228ec093aa07)  
[4] [ubuntu18.04にSoftEther VPN Clientをインストール](https://qiita.com/atomyah/items/0edda0c93a4147381aa5)  
[5] [SoftEtherでVPN環境を作ろう](https://www.linuxmania.jp/softether-vpn.html)

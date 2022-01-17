# windowsでのROS2インストール方法


## 導入環境

| OS | ROS2 version |
|:-:|:-:|
| Windows 10 | Foxy |

<br>

## chocolateyをインストール

Chocolateyはapt-getのwindows版のようなもの。
管理者権限でwindows powershellを開き、以下を実行する。

```
> Set-ExecutionPolicy Bypass -Scope Process -Force; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
```

## Pythonのインストール

Chocolateyを利用してPythonをインストールする。

```
> choco install -y python --version 3.8.3
```

C:\python38にインストールされていることを確認する。

## Visual C ++再配布パッケージのインストール

コマンドプロンプトで以下を入力してインストールする。

```
> choco install -y vcredist2013 vcredist140
```

## OpenSSLのインストール
### 1.インストーラーのダウンロード

以下のURLからWindows用のOpenSSLのインストーラーをダウンロードする。
サイト内でWin64 OpenSSL v1.1.1LのEXEを選択する。(2021年11月現在)

https://slproweb.com/products/Win32OpenSSL.html

インストーラーをすべてのオプションをデフォルトで実行し、インストールする。

### 2.環境変数の設定

コマンドプロンプトを開き以下を実行する。

```
> setx -m OPENSSL_CONF "C:\Program Files\OpenSSL-Win64\bin\openssl.cfg"
```
### 3.OpenSSLをPATH環境変数に追加する

1.設定を開き、｢環境変数｣で検索して｢環境変数を編集｣を選択する。<br>
2.｢Path｣を選択し、編集をクリックする。<br>
3.新規をクリックし、C:\Program Files\OpenSSL-Win64\bin\ を追加する。<br>

## Visual Studio 2019のインストール 

以下のURLからMicrosoftのアカウントにログイン後Visual Studio Community 2019 をダウンロードする。

https://my.visualstudio.com/Downloads?q=visual%20studio%202019&wt.mc_id=o~msft~vscom~older-downloads

インストールの詳細が表示されるため、｢C++によるデスクトップ開発｣を選択し、インストールする。

## OpenCVのインストール

### 1.ダウンロード

以下のURLからダウンロードして C:\opencv に解凍する。

https://github.com/ros2/ros2/releases/download/opencv-archives/opencv-3.4.6-vc16.VS2019.zip 

### 2.環境変数の設定

コマンドプロンプトを開き以下を実行する。

```
> setx -m OpenCV_DIR C:\opencv
```
### 3.OpenSSLをPATH環境変数に追加する

1.設定を開き、｢環境変数｣で検索して｢環境変数を編集｣を選択する。<br>
2.｢Path｣を選択し、編集をクリックする。<br>
3.新規をクリックし、C:\opencv\x64\vc16\bin を追加する。<br>　

## 依存関係のインストール

1.CMaKeをインストールする。
```
> choco install -y cmake
```

2.設定を開き、環境変数に以下のPATHを追加する。

C:\Program Files\CMake\bin

3.以下のURLから下記のファイルをダウンロードし、任意の箇所に置く。

https://github.com/ros2/choco-packages/releases/tag/2020-02-24

・asio.1.12.1.nupkg <br>
・bullet.2.89.0.nupkg <br>
・cunit.2.1.3.nupkg <br>
・eigen-3.3.4.nupkg <br>
・tinyxml-usestl.2.6.2.nupkg <br>
・tinyxml2.6.0.0.nupkg <br>
・log4cxx.0.10.0.nupkg <br>

4.管理者権限でコマンドプロンプトを開き、Path to downloadsをファイルを置いたディレクトリ名に変更して実行する。
```
> choco install -y -s <PATH\TO\DOWNLOADS> asio cunit eigen tinyxml-usestl tinyxml2 log4cxx bullet
```

5.必要パッケージのインストール
```
> python -m pip install -U catkin_pkg cryptography empy ifcfg lark-parser lxml netifaces numpy opencv-python pyparsing pyyaml setuptools rosdistro
> python -m pip install -U pydot PyQt5
> choco install graphviz
```

6.設定を開き、環境変数に以下のPATHを追加する。

C:\Program Files (x86)\GraphvizX.XX\bin

## ROS2のインストール

1.以下のURLからWindows用の最新パッケージをダウンロードする。(2021年11月現在はros2-foxy-20211013-windows-release-amd64.zip)

https://github.com/ros2/ros2/releases

2.C:\dev\ros2に解凍する。

3.環境変数を設定する。<br>
ros2_windowsという名前のファイルの中にlocal_setup.batが入っているため、ファイルを外に取り出すor下記のパスに\ros2-windowsを追加する作業が必要。
```
> call C:\dev\ros2\local_setup.bat
```
「Warning:~」と警告メッセージが出るがノードが動けば大丈夫。

## 動作確認

コマンドプロンプトを開いて以下を実行する。
```
> call C:\dev\ros2\local_setup.bat
> ros2 run demo_nodes_cpp talker
```
別のコマンドプロンプトで以下を実行する。
```
> call C:\dev\ros2\local_setup.bat
> ros2 run demo_nodes_py listener
```
talkerとlistenerからメッセージが出ていれば成功。

## 追記

pythonの別のバージョンがあると上手く動かないことがある。
もしそうなった場合は別バージョンのpythonをアンインストールする必要がある。

## 参考

[1]https://docs.ros.org/en/foxy/Installation/Windows-Install-Binary.html <br>
[2]https://qiita.com/matryorobotics/items/beab21d4cf3199b1f6ff <br>

# Dockerのセットアップ

## GPUなしPC

基本的に[このサイト](https://docs.docker.com/engine/install/ubuntu/)に書いてある通りに実行するだけ．  
[Nvidiaのサイト](https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/install-guide.html)によれば，インストールスクリプトなるものがあるらしいです．

## GPUありPC

[NVIDIA Container Toolkit](https://github.com/NVIDIA/nvidia-docker)をインストールすることで，DockerコンテナでGPUリソースを使用することができる．  
GPUリソースはDockerコンテナでGPUでの機械学習やGUIによる描画を行う際に必要となる．  
GPUなしPCで行った作業でDockerのインストールが完了した後，NVIDIA Container Toolkitをインストールする．  

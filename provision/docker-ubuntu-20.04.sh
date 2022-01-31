#!/bin/bash -euxv
# https://www.digitalocean.com/community/tutorials/how-to-install-and-use-docker-on-ubuntu-20-04-ja

################################################################################
# docker インストール
################################################################################
sudo apt update
# apt が HTTPS 経由でパッケージを使用できるようにするいくつかの必要条件パッケージをインストール
sudo apt install apt-transport-https ca-certificates curl software-properties-common -y
# 公式 Docker リポジトリの GPG キーをシステムに追加
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
# Docker リポジトリを APT ソースに追加
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu focal stable"
# 追加されたリポジトリから Docker パッケージでパッケージデータベースを更新
sudo apt update
# デフォルトのUbuntuリポジトリではなく、Dockerリポジトリからインストールしようとしていることを確認
apt-cache policy docker-ce
# Docker をインストール
sudo apt install docker-ce -y
# 実行されていることを確認
sudo systemctl is-active docker

################################################################################
# docker 設定
################################################################################
# docker コマンドを実行するたびに sudo を入力しないようにするために、ユーザーを docker グループに追加
sudo usermod -aG docker vagrant
# ユーザーがdockerグループに追加されたことを確認
groups vagrant | grep docker
# Dockerに関するシステム全体の情報を表示
sudo docker info
# Docker Hubからイメージにアクセスしダウンロードできるかどうかを確認
sudo docker run hello-world
# 使い終わったコンテナとイメージを削除
sudo docker container prune -f
sudo docker image prune -a -f

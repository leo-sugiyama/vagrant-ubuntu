#!/bin/bash -euxv
# https://www.digitalocean.com/community/tutorials/how-to-install-and-use-docker-compose-on-ubuntu-20-04-ja

# json processor のインストール (最新バージョン取得に使う)
sudo apt install jq -y
# 最新バージョンをダウンロード
LATEST=$(curl -s https://api.github.com/repos/docker/compose/releases/latest)
VERSION=$(echo $LATEST | jq -r .tag_name)
KERNEL=$(uname -s | tr A-Z a-z)
MACHINE=$(uname -m | tr A-Z a-z)
DOWNLOAD_URL=$(curl -s https://api.github.com/repos/docker/compose/releases/latest | jq -r ".assets[] | select(.name == \"docker-compose-$KERNEL-$MACHINE\").browser_download_url")
sudo curl -L $DOWNLOAD_URL -o /usr/local/bin/docker-compose
# 実行権限を付与
sudo chmod +x /usr/local/bin/docker-compose
# コマンドライン補完のインストール
sudo curl -L https://raw.githubusercontent.com/docker/compose/$(docker-compose version --short)/contrib/completion/bash/docker-compose --create-dirs -o /etc/bash_completion.d/docker-compose
# 実行できることを確認
docker-compose --version

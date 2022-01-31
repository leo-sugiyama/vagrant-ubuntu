# vim: set fileencoding=utf-8 filetype=ruby expandtab tabstop=2 softtabstop=2 shiftwidth=2 :

unless Vagrant.has_plugin?("vagrant-reload")
  raise "vagrant-reload plugin is not installed!"
end

if File.exist?("config.yml")
  require "yaml"
  extconf = YAML::load(File.open("config.yml"))
else
  raise "config.yml not found."
end

Vagrant.configure("2") do |config|
  config.vm.box         = "bento/ubuntu-20.04"
  config.vm.network     "public_network", bridge: extconf["network_bridge"]
  config.vm.hostname    = extconf["hostname"]
  config.vm.synced_folder \
    ".", "/vagrant", \
    type: "smb", smb_username: extconf["username"], smb_password: extconf["password"]

  config.vm.provider "hyperv" do |hv|
    hv.vmname       = extconf['vmname']
    hv.cpus         = 2
    hv.memory       = "4096"
    hv.maxmemory    = "8192"
  end

  config.vm.provision "basic", type: "shell", inline: <<-SHELL
    # パッケージ情報更新
    sudo apt update
    sudo apt upgrade --yes
    # 日本語言語パックのインストール
    sudo apt -y install language-pack-ja
    # ロケールを日本語に設定
    sudo localectl set-locale LANG=ja_JP.UTF-8
    # タイムゾーンの設定 (Asia/Tokyo)
    sudo timedatectl set-timezone Asia/Tokyo
    # 日本語マニュアルのインストール
    sudo apt install manpages-ja manpages-ja-dev --yes
    # bash 補完の有効化
    sudo apt install bash-completion --yes
  SHELL

  config.vm.provision :reload

  config.vm.provision "netplan", type: "shell", inline: <<-SHELL
    # 固定(静的) IP 設定
    sudo cp /vagrant/provision/10-netcfg.yaml /etc/netplan
    sudo chmod 644 /etc/netplan/10-netcfg.yaml
    sudo netplan apply
  SHELL

  config.vm.provision "mdns", type: "shell", inline: <<-SHELL
    # パッケージ情報更新
    sudo apt update
    # multicast DNS で名前解決できるようにする
    sudo apt -y install avahi-daemon
  SHELL

  config.vm.provision "docker", type: "shell", inline: <<-SHELL
    # docker, docker-compose のインストール
    /vagrant/provision/docker-ubuntu-20.04.sh
    /vagrant/provision/docker-compose-ubuntu-20.04.sh
  SHELL
end

# vim: set fileencoding=utf-8 filetype=ruby expandtab tabstop=2 softtabstop=2 shiftwidth=2 :

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
  SHELL

  config.vm.provision "mdns", type: "shell", inline: <<-SHELL
    # パッケージ情報更新
    sudo apt update
    # multicast DNS で名前解決できるようにする
    sudo apt -y install avahi-daemon
  SHELL
end

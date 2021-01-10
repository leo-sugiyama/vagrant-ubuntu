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

  config.vm.provider "hyperv" do |hv|
  end
end

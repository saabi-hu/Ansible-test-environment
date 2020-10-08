# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

  config.vm.box = "centos/8"
  config.vm.network "private_network", type: "dhcp", virtualbox_intnet: "ansibletest"

  config.vm.define "master" do |master|
    master.vm.hostname = "master.local"
    master.vm.provision :shell, path: "bootstrap_master.sh"
  end

  (1..3).each do |i|
    config.vm.define "node-#{i}" do |node|
      node.vm.hostname = "node-#{i}.local"
      node.vm.provision :shell, path: "bootstrap_slave.sh"
    end
  end
end

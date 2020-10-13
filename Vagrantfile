# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

  config.vm.box = "centos/8"
  config.vm.network "private_network", type: "dhcp", virtualbox_intnet: "ansible"

  (1..3).each do |i|
    config.vm.define "node-#{i}.local" do |node|
      node.vm.hostname = "node-#{i}.local"
      node.vm.provision :file, source: "provisioning/id_rsa.pub", destination: "~/.ssh/master_id_rsa.pub"
      node.vm.provision :shell, path: "bootstrap_slave.sh"
    end
  end

  config.vm.define "master.local", primary: true do |master|
    master.vm.hostname = "master.local"
    master.vm.provision :file, source: "provisioning/id_rsa", destination: "~/.ssh/id_rsa"
    master.vm.provision :file, source: "provisioning/id_rsa.pub", destination: "~/.ssh/id_rsa.pub"
    master.vm.provision :file, source: "provisioning/ansible.cfg", destination: "~/.ansible.cfg"
    master.vm.provision :shell, path: "bootstrap_master.sh"
    master.vm.provision :ansible_local do |ansible|
      ansible.playbook = "provisioning/playbook.yml"
      ansible.become = true
      ansible.verbose = true
      ansible.limit = "all"
    end
  end
end

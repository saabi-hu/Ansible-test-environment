# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

  config.vm.box = "centos/8"
  # use host-only network
  # config.vm.network "private_network", type: "dhcp", virtualbox_intnet: "ansible"
  # or use the public network to reach the servers from outside
  config.vm.network "public_network"

  (0..0).each do |i|
    config.vm.define "node-#{i}" do |node|
      node.vm.hostname = "node-#{i}"
      node.vm.provision :file, source: "provisioning/id_rsa.pub", destination: "~/.ssh/master_id_rsa.pub"
      node.vm.provision :shell, path: "bootstrap_slave.sh"
    end
  end

  config.vm.define "master", primary: true do |master|
    master.vm.hostname = "master"
    master.vm.provision :file, source: "provisioning/id_rsa", destination: "~/.ssh/id_rsa"
    master.vm.provision :file, source: "provisioning/id_rsa.pub", destination: "~/.ssh/id_rsa.pub"
    master.vm.provision :file, source: "provisioning/ansible.cfg", destination: "~/.ansible.cfg"
    master.vm.provision :shell, path: "bootstrap_master.sh"
    master.vm.provision :ansible_local do |ansible|
      ansible.playbook = "provisioning/playbook.yml"
      ansible.become = true
      ansible.verbose = true
      ansible.limit = "all"
      ansible.groups = {
        "all:vars" => {"host_domain" => "local",
                       "ansible_host" => "{{inventory_hostname}}.{{host_domain}}"}
      }
    end
  end
end

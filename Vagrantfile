# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

  config.vm.box = "centos/stream8"
  config.vm.network "private_network", type: "dhcp", virtualbox_intnet: "ansible"

  (0..9).each do |i|
    config.vm.define "node-#{i}" do |node|
      node.vm.hostname = "node-#{i}"
      node.vm.provision :file, source: "provisioning/id_ed25519.pub", destination: "~/.ssh/master_id_ed25519.pub"
      node.vm.provision :shell, path: "bootstrap_slave.sh"
    end
  end

  config.vm.define "master", primary: true do |master|
    master.vm.hostname = "master"
    master.vm.provision :file, source: "provisioning/id_ed25519", destination: "~/.ssh/id_ed25519"
    master.vm.provision :file, source: "provisioning/id_ed25519.pub", destination: "~/.ssh/id_ed25519.pub"
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

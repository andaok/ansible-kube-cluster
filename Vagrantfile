# -*- mode: ruby -*-
# vi: set ft=ruby :
ENV["LC_ALL"] = "en_US.UTF-8"
masters = {
  "k8smaster1" => "192.168.2.10",
  "k8smaster2" => "192.168.2.20",
  "k8smaster3" => "192.168.2.30"
}

nodes = {
  "k8snode1" => "192.168.2.40",
  "k8snode2" => "192.168.2.50",
  "k8sconsole" => "192.168.2.100"
}

Vagrant.configure("2") do |config|
  config.vm.box = "centos/7"
  config.vm.synced_folder ".","/vagrant" ,disabled: false
  config.ssh.insert_key=false

  masters.each do |master,ip|
    config.vm.define master do |server|
      server.vm.hostname = master
      server.vm.network "private_network",ip: ip
      server.vm.provider "virtualbox" do |v|
        v.name = master
        v.customize ["modifyvm",:id,"--memory", "1024"]
      end
    end
  end

  nodes.each do |node,ip|
    config.vm.define node do |client|
      client.vm.hostname = node
      client.vm.network "private_network",ip: ip
      client.vm.provider "virtualbox" do |v|
        v.name = node
        v.customize ["modifyvm",:id,"--memory","3072"]
      end
    end
  end

end

# -*- mode: ruby -*-
# vi: set ft=ruby :

require 'json'
vars = JSON.parse(File.read('vars.json'))

SERVER_COUNT=3
SUBNET="192.168.1.20"
SERVERS = []
(1..SERVER_COUNT).each do |i|
    SERVERS << {
        "ip" => "#{SUBNET}#{i}",
        "number" => i,
        "name" => "swarm-node-#{i}"
    }
end
SERVERS_IPS = SERVERS.map{ |server| server["ip"]}

Vagrant.configure(2) do |config|
#   config.vm.box = "bento/ubuntu-16.04" # 16.04 LTS
  config.vm.box = "ubuntu/bionic64" # 18.04 LTS
  config.vm.provider "virtualbox" do |vb|
        vb.memory = "1024"
  end

  SERVERS.each do |server|
    config.vm.define server["name"] do |n|
      n.vm.hostname = server["name"]
      n.vm.provision "shell", path: "provision.sh", :args => [server["name"], vars["slack_token"]]
      n.vm.provider :virtualbox do |v, override|
         override.vm.hostname = server["name"]
         v.name = server["name"]
         override.vm.network :public_network, bridge: "en0: Wi-Fi", ip: "#{server["ip"]}"
       end
      n.vm.hostname = server["name"]
    end
    config.vm.provision "file", source: "./node-ansible", destination: '/home/vagrant/ansible'
  end
end

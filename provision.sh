#!/bin/bash

mkdir -p /var/log/provision
exec >/var/log/provision/provision.log 2>/var/log/provision/provision-error.log

NODE_NAME="$1"
SLACK_TOKEN="$2"

echo "SLACK_TOKEN=\"$SLACK_TOKEN\"" >> /etc/environment

export NODE_IP=$(/sbin/ifconfig  | grep 'inet ' | awk '{ print $2}' | grep 192)
echo "NODE_IP=\"$NODE_IP\"" >> /etc/environment

prepareSystem() {
  echo $'\e[1;33m'Preparing system$'\e[0m'
  apt update -y
  apt upgrade -y
  addAlias ""
}

installAnsible() {
  echo $'\e[1;33m'Installing Ansible$'\e[0m'
  apt-add-repository ppa:ansible/ansible -y
  apt install ansible -y
}

provision() {
  cd /home/vagrant/ansible
  echo $'\e[1;33m'Running Ansible playbook$'\e[0m'
  ansible-playbook main.yml \
    --extra-vars "node_ip=$NODE_IP"
}


prepareSystem
installAnsible
provision

echo "Node provisioned" > /provision.txt

echo $'\e[1;32m'Node provisioned successfully!$'\e[0m'

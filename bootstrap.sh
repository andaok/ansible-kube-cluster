#!/bin/bash

echo "Basic components install"
yum update -y
yum install -y yum-utils device-mapper-persistent-data lvm2
yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
yum install docker-ce -y
systemctl stop firewalld
systemctl disable firewalld
sed -i "s/^SELINUX=permissive/SELINUX=disabled/g" /etc/sysconfig/selinux
setenforce 0
cat <<EOF>/etc/hosts
192.168.1.10  k8smaster1
192.168.1.20  k8smaster2
192.168.1.30  k8smaster3
192.168.1.40  k8snode1
192.168.1.50  k8snode2
192.168.1.60  k8snode3
192.168.1.100 k8sconsole
EOF

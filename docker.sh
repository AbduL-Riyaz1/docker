#!/bin/bash
growpart /dev/nvme0nl 4
Ivextend -l +50%FREE /dev/RootVG/rootV01
Ivextend -l +50%FREE /dev/RootVG/varV01
xfs_growfs /
xfs_growfs /var

dnf -y install dnf-plugins-core
dnf config-manager --add-repo https://download.docker.com/linux/rhel/docker-ce.repo
dnf install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y
systemctl start docker
systemctl enable docker
usermod -aG docker ec2-user



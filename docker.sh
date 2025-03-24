#!/bin/bash

# Resize partitions
growpart /dev/nvme0n1 4  # Check your actual disk name using `lsblk`

# Extend logical volumes
lvextend -l +50%FREE /dev/RootVG/rootV01
lvextend -l +50%FREE /dev/RootVG/varV01

# Grow filesystem
xfs_growfs /
xfs_growfs /var

# Install Docker
dnf -y install dnf-plugins-core
dnf config-manager --add-repo https://download.docker.com/linux/rhel/docker-ce.repo
dnf install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# Start and enable Docker service
systemctl start docker
systemctl enable docker

# Add ec2-user to Docker group
usermod -aG docker ec2-user


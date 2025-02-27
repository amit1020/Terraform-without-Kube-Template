#!/bin/bash
set -ex  # Enable debugging

echo "Running user-data script" | tee -a /var/log/user-data.log

# Detect Amazon Linux version
OS_VERSION=$(grep -oP '(?<=^VERSION_ID=")[^"]*' /etc/os-release)

if [[ "$OS_VERSION" == "2" ]]; then
    echo "Amazon Linux 2 detected" | tee -a /var/log/user-data.log
    sudo yum update -y
    sudo yum install -y amazon-linux-extras || true  # Install amazon-linux-extras if missing
    sudo amazon-linux-extras enable docker || true
    sudo yum install -y docker git openssl
elif [[ "$OS_VERSION" == "2023" ]]; then
    echo "Amazon Linux 2023 detected" | tee -a /var/log/user-data.log
    sudo dnf install -y docker git openssl
    echo "Done to install docker and git" | tee -a /var/log/user-data.log
    sudo curl -L "https://github.com/docker/compose/releases/download/v2.20.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
    sudo chmod +x /usr/local/bin/docker-compose
    echo "Docker Compose installation complete" | tee -a /var/log/user-data.log
else
    echo "Unsupported OS version: $OS_VERSION" | tee -a /var/log/user-data.log
    exit 1
fi

# Start and enable Docker
sudo systemctl start docker
sudo systemctl enable docker
sudo usermod -aG docker ec2-user

# Allow docker commands without logout
newgrp docker

# Confirm installations
docker --version | tee -a /var/log/user-data.log
git --version | tee -a /var/log/user-data.log

echo "Docker & Git and Docker-Compose installation completed!" | tee -a /var/log/user-data.log

git clone https://github.com/amit1020/PhishingScanPlatform.git /home/ec2-user/PhishingScanPlatform
cd /home/ec2-user/PhishingScanPlatform
echo "Success to clone"  | tee -a /var/log/user-data.log 



mkdir /home/ec2-user/PhishingScanPlatform/app_data/keys 
cd /home/ec2-user/PhishingScanPlatform/app_data/keys
openssl genpkey -algorithm RSA -out Private.pem -pkeyopt rsa_keygen_bits:4096
openssl rsa -in Private.pem -pubout -out Public.pem
echo "Finish create keys" | tee -a /var/log/user-data.log

sudo chown -R ec2-user:ec2-user /home/ec2-user/PhishingScanPlatform
sudo chmod -R 700 /home/ec2-user/PhishingScanPlatform

echo "Change permission for wait-for-connection.sh" | tee -a /var/log/user-data.log


cd /home/ec2-user/PhishingScanPlatform
sudo docker-compose -f docker_compose.yml up -d 


echo "Complete everything!!"| tee -a /var/log/user-data.log




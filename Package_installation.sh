#!/bin/bash

# Function to install packages on Debian-based systems (like Ubuntu)
install_debian() {
    sudo apt update
    sudo apt install -y git maven unzip zip
    sudo apt install -y openjdk-17-jre
    curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key | sudo tee \
      /usr/share/keyrings/jenkins-keyring.asc > /dev/null
    echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \
         https://pkg.jenkins.io/debian-stable binary/ | sudo tee \
         /etc/apt/sources.list.d/jenkins.list > /dev/null
    sudo apt-get update
    sudo apt-get install -y jenkins
    sudo systemctl enable jenkins
    sudo systemctl start jenkins
    sudo systemctl status jenkins
}

# Function to install packages on Red Hat-based systems (like CentOS)
install_redhat() {
    sudo yum update -y
    sudo yum install -y git maven unzip zip
    sudo wget -O /etc/yum.repos.d/jenkins.repo \
       https://pkg.jenkins.io/redhat-stable/jenkins.repo
    sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key
    sudo yum upgrade -y
    # Add required dependencies for the jenkins package
    sudo yum install java-17-openjdk
    sudo yum install jenkins
    sudo systemctl daemon-reload
    sudo systemctl enable jenkins
    sudo systemctl start jenkins
    sudo systemctl status jenkins
}

# Detect the Linux distribution
if [ -f /etc/os-release ]; then
    source /etc/os-release
    if [[ $ID == "ubuntu" || $ID_LIKE == *"debian"* ]]; then
        install_debian
    elif [[ $ID == "centos" || $ID == "rhel" ]]; then
        install_redhat
    else
        echo "Unsupported distribution: $ID"
        exit 1
    fi
else
    echo "Unable to detect distribution."
    exit 1
fi

echo "Packages (Git, Maven, Java, Unzip, Zip) installation complete."

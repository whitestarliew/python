#!/bin/bash

touch check_version.txt
############################git installation ###############################
sudo apt -y install git-all
sudo git --version >> version.txt

############################ Visual Code installation ######################
sudo apt -y install apt-transport-https
sudo apt update
sudo apt -y install code
sudo code --version >> version.txt
########################### Python Installation##################################
echo "Installing python..."
sudo apt install python3
if ! command -v python3 &> /dev/null; then
  echo "Python 3 is not installed. Installing..."
  # Replace with the appropriate installation command for your operating system
  sudo apt install python3  # Example for Ubuntu/Debian

  if [[ $? -eq 0 ]]; then
    echo "Successfully installed Python 3."
  else
    echo "Failed to install Python 3. Exiting..."
    exit 1
  fi
fi


sudo apt install build-essential zlib1g-dev libncurses5-dev libgdbm-dev libnss3-dev libssl-dev libreadline-dev libffi-dev wget

############################docker installation ################################
sudo apt -y update

if sudo apt update -y; then  
  echo "Update successful!"
else
  echo "Failed to update package lists. Please check your network connection or system logs for errors."
  exit 1  # Stop the script if update fails
fi

for pkg in docker.io docker-doc docker-compose docker-compose-v2 podman-docker containerd runc; do sudo apt-get remove $pkg; done

#New docker installation 
# Add Docker's official GPG key:
sudo apt-get update
sudo apt-get install ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

# Add the repository to Apt sources:
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
# Start Docker service
sudo systemctl start docker

if systemctl status docker | grep "active (running)" &> /dev/null; then
  echo "Docker installation complete!"
else
  echo "Failed to start Docker service. Please check your script or system logs for errors."
  systemctl stop docker &> /dev/null
  exit 1
fi
# Verify installation
echo "Docker installation complete!"

#############################Install Jenkins ####################################### 
# Install Java runtime for Jenkins

sudo apt -y update
sudo apt -y install fontconfig openjdk-17-jre

java -version 
openjdk version "17.0.8" 2023-07-18
OpenJDK Runtime Environment (build 17.0.8+7-Debian-1deb12u1)
OpenJDK 64-Bit Server VM (build 17.0.8+7-Debian-1deb12u1, mixed mode, sharing)
sudo wget -O /usr/share/keyrings/jenkins-keyring.asc \
  https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key
echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \
  https://pkg.jenkins.io/debian-stable binary/ | sudo tee \
  /etc/apt/sources.list.d/jenkins.list > /dev/null
sudo apt-get update
sudo apt-get install jenkins -y
sudo cat /var/lib/jenkins/secrets/initialAdminPassword >> check_version.txt
# Install Jenkins
if apt-get install  jenkins -y 2>/dev/null; then  # Suppress standard output to avoid cluttering
  echo "Jenkins installation complete!"
else
  echo "Jenkins installation failed. Please check your script or system logs for errors."
  exit 1
fi

###### GRAFANA INSTALLATION ################

# Installs the latest OSS release:

###################### Micro kubernetes installation #########
sudo snap install microk8s --classic
sudo usermod -a -G microk8s $USER 
sudo microk8s status --wait-ready
#Turn on the service you want 
sudo microk8s enable dashboard
sudo microk8s enable community -y 
sudo microk8s enable dns
sudo microk8s enable registry
sudo microk8s enable istio 
sudo microk8s kubectl get all --all-namespaces
# sudo microk8s dashboard-proxy


######################### terraform installation ####################################
sudo apt-get update && sudo apt-get install -y gnupg software-properties-common
# install GPG key Hashicorp 
wget -O- https://apt.releases.hashicorp.com/gpg | \
gpg --dearmor | \
sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg
#Verification 
gpg --no-default-keyring \
--keyring /usr/share/keyrings/hashicorp-archive-keyring.gpg \
--fingerprint
#Add repo to your system 
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] \
https://apt.releases.hashicorp.com $(lsb_release -cs) main" | \
sudo tee /etc/apt/sources.list.d/hashicorp.list
sudo apt update -y 
sudo apt-get install terraform -y 
#Enable tab 
sudo touch ~/.bashrc
sudo terraform -install-autocomplete
echo "Successfull install Docker, Jenkins, Grafana, VS Code, Python" 
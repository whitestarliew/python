#!/bin/bash

touch check_version.txt
############################git installation ###############################
sudo apt -y install git-all
sudo git --version >> check_version.txt

############################SSH installation #################################
sudo apt install openssh-client -y
########################## Remove thunderbird ################################
sudo apt-get purge thunderbird* -y


###########################homebrew installation ###########################
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
############################ Visual Code installation ######################
sudo apt -y install apt-transport-https
sudo apt update -y 
sudo apt -y install code
sudo code --version >> check_version.txt
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
sudo python3 --version >> check_version.txt

sudo apt install build-essential zlib1g-dev libncurses5-dev libgdbm-dev libnss3-dev libssl-dev libreadline-dev libffi-dev wget

#############################Install Jenkins ####################################### 
# Install Java runtime for Jenkins

sudo apt -y update
sudo apt -y install fontconfig openjdk-17-jre

java -version >> check_version.txt
# Ensure script is run with root privileges (use with caution)
if [[ $EUID -ne 0 ]]; then
  echo "This script requires root privileges. Please run it with sudo."
  exit 1
fi

# Define the key download URL and package source list URL
key_url="https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key"
source_url="https://pkg.jenkins.io/debian-stable binary/"
# Download the Jenkins key
wget -O /usr/share/keyrings/jenkins-keyring.asc "$key_url"
# Add the Jenkins repository to sources list
echo "deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] $source_url" | sudo tee /etc/apt/sources.list.d/jenkins.list > /dev/null
# Inform the user of successful execution (optional)
echo "Jenkins key downloaded and repository added successfully."
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

######################## GRAFANA INSTALLATION ################
sudo apt-get install -y apt-transport-https software-properties-common wget
#import GPG key 
sudo mkdir -p /etc/apt/keyrings/
wget -q -O - https://apt.grafana.com/gpg.key | gpg --dearmor | sudo tee /etc/apt/keyrings/grafana.gpg > /dev/null
#Add repo to stable release
echo "deb [signed-by=/etc/apt/keyrings/grafana.gpg] https://apt.grafana.com stable main" | sudo tee -a /etc/apt/sources.list.d/grafana.list
#add repo to beta release 
echo "deb [signed-by=/etc/apt/keyrings/grafana.gpg] https://apt.grafana.com beta main" | sudo tee -a /etc/apt/sources.list.d/grafana.list
# Updates the list of available packages
sudo apt-get update -y
# Installs the latest OSS release:
sudo apt-get install grafana -y 
# Installs the latest Enterprise release:
sudo apt-get install grafana-enterprise -y


###################### Micro kubernetes installation ##############################
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
sudo apt-get update -y && sudo apt-get install -y gnupg software-properties-common
# install GPG key Hashicorp 
wget -O- https://apt.releases.hashicorp.com/gpg | \
gpg --dearmor | \
sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg
#Verification 
gpg --no-default-keyring \
--keyring /usr/share/keyrings/hashicorp-archive-keyring.gpg \
--fingerprint
#Add repo to your system 
sudo echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] \
https://apt.releases.hashicorp.com $(lsb_release -cs) main" | \
sudo tee /etc/apt/sources.list.d/hashicorp.list
sudo apt update -y 
sudo apt-get install terraform -y 
#Enable tab 
sudo touch ~/.bashrc
sudo terraform -install-autocomplete
terraform --version >> check_version.txt

######################### Ansible installation #################################
sudo apt update -y
sudo apt install software-properties-common -y
sudo add-apt-repository --yes --update ppa:ansible/ansible
sudo apt install ansible -y
sudo ansible --version >> check_version.txt

dh -h | head -4 >> check_version.txt

echo "Successfull install Docker, Jenkins, Grafana, VS Code, Python" 

############################## AWSCLI installation ##############################
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install
cat check_version.txt

############################docker installation ################################
# Add Docker's official GPG key:
sudo apt-get update -y
sudo apt-get install ca-certificates curl -y
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

# Ensure script is run with root privileges (use with caution)
# Define the Docker repository and key download URL
repo_url="https://download.docker.com/linux/ubuntu"
key_url="https://download.docker.com/linux/ubuntu/gpg"
# Download the Docker GPG key
wget -qO- "$key_url" | sudo apt-key add -
# Add the Docker repository to Apt sources
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] $repo_url $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update -y 
# Start Docker service
sudo systemctl start docker

if systemctl status docker | grep "active (running)" &> /dev/null; then
  echo "Docker installation complete!"
else
  echo "Failed to start Docker service. Please check your script or system logs for errors."
  systemctl stop docker &> /dev/null
  exit 1
fi

sudo docker --version >> check_version.txt
# Verify installation
echo "Docker installation complete!"
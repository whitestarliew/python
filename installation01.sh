#!/bin/bash


############################git installation ###############################
sudo apt -y install git-all


############################ Visual Code installation ######################
sudo apt install apt-transport-https
sudo apt update

############################# Visual Code installation #####################
sudo apt install code

########################### Install python ##################################
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
sudo apt-get install -y openjdk-17-jre

curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io.key | sudo tee /usr/share/keyrings/jenkins-keyring.asc > /dev/null
echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] https://pkg.jenkins.io/debian-stable binary/ | sudo tee /etc/apt/sources.list.d/jenkins.list > /dev/null
sudo apt-get install -y jenkins
# Install Jenkins
if apt install -y jenkins 2>/dev/null; then  # Suppress standard output to avoid cluttering
  echo "Jenkins installation complete!"
else
  echo "Jenkins installation failed. Please check your script or system logs for errors."
  exit 1
fi

###### GRAFANA INSTALLATION ################
sudo apt-get install -y apt-transport-https software-properties-common wget
sudo mkdir -p /etc/apt/keyrings/
wget -q -O - https://apt.grafana.com/gpg.key | gpg --dearmor | sudo tee /etc/apt/keyrings/grafana.gpg > /dev/null

echo "deb [signed-by=/etc/apt/keyrings/grafana.gpg] https://apt.grafana.com stable main" | sudo tee -a /etc/apt/sources.list.d/grafana.list
echo "deb [signed-by=/etc/apt/keyrings/grafana.gpg] https://apt.grafana.com beta main" | sudo tee -a /etc/apt/sources.list.d/grafana.list
echo "deb [signed-by=/etc/apt/keyrings/grafana.gpg] https://apt.grafana.com beta main" | sudo tee -a /etc/apt/sources.list.d/grafana.list

sudo apt-get update

# Installs the latest OSS release:
apt-get -y install grafana

if apt install -y grafana 2>/dev/null; then  # Suppress standard output
  echo "Grafana installation successful!"
else
  echo "Failed to install Grafana. Please check your script or system logs for errors."
  exit 1
fi
# Installs the latest Enterprise release:
sudo apt-get -y install grafana-enterprise

if sudo apt-get -y install grafana-enterprise 2>/dev/null; then 
  echo "Grafana-enterprice installation successful!"
else
  echo "Failed to install Grafana-Enterprise. Please check your script or system logs for errors."
  exit 1
fi



echo "Successfull install Docker, Jenkins, Grafana, VS Code, Python" 
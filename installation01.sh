#!/bin/bash


############################git installation ###############################
sudo apt install git-all


############################docker installation ################################
# Check if root privileges are available
if [[ $EUID -ne 0 ]]; then
  # Prepend 'sudo' to the command if not root
  sudo -E $*
  exit 1
fi
# Update package lists
sudo apt -y update

if sudo apt update -y; then  
  echo "Update successful!"
else
  echo "Failed to update package lists. Please check your network connection or system logs for errors."
  exit 1  # Stop the script if update fails
fi
# Add Docker repository
sudo apt install -y apt-transport-https ca-certificates curl software-properties-common
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
# Update package lists again
sudo apt -y update 
# Install Docker engine and CLI
sudo apt install -y docker-ce docker-ce-cli docker-compose

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



echo "Successfull install Docker, Jenkins, Grafana" 
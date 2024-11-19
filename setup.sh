#!/bin/bash

# System setup
echo "Update"
yes | sudo apt-get update

echo "Upgrade"
yes | sudo apt-get upgrade

echo "Installing Terminator"
yes | sudo apt install terminator

echo "Installing tmux"
yes | sudo apt-get install tmux

echo "Setting up SSH Server, net tools, GIT"
yes | sudo apt-get install openssh-server net-tools git htop

echo "Github Credential Save"
git config --global credential.helper store

echo "Installing Gparted"
yes | sudo apt-get install gparted

echo "Installing pip and other python packages"
yes | sudo apt install python3-pip 
yes | pip3 install opencv-python
yes | pip3 install numpy
yes | pip3 install matplotlib
yes | pip3 install pandas
yes | pip3 install opencv-contrib-python
yes | pip3 install scipy

sudo snap install code --classic

sudo apt install -y software-properties-common
sudo add-apt-repository universe
sudo apt update && sudo apt install curl -y
sudo curl -sSL https://raw.githubusercontent.com/ros/rosdistro/master/ros.key -o /usr/share/keyrings/ros-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/ros-archive-keyring.gpg] http://packages.ros.org/ros2/ubuntu $(. /etc/os-release && echo $UBUNTU_CODENAME) main" | sudo tee /etc/apt/sources.list.d/ros2.list > /dev/null
sudo apt update
sudo apt upgrade
sudo apt install ros-humble-desktop
sudo apt install ros-humble-ros-base
sudo apt install ros-dev-tools

touch ~/.bash_aliases
echo "source /opt/ros/humble/setup.bash" >> ~/.bash_aliases
echo "source /usr/share/colcon_cd/function/colcon_cd.sh" >> ~/.bash_aliases
echo "export _colcon_cd_root=/opt/ros/humble/" >> ~/.bashrc
echo "source /usr/share/colcon_argcomplete/hook/colcon-argcomplete.bash" >> ~/.bash_aliases

ssh-keygen -t ed25519 -C "christo12aluckal@gmail.com"
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_ed25519

Color_Off='\033[0m'
Green='\033[0;32m'
echo -e "${Green}`cat ~/.ssh/id_ed25519.pub`${Color_Off}"

git config --global user.name "Christo Aluckal"
git config --global user.email "christo12aluckal@gmail.com"
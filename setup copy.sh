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
export ROS_APT_SOURCE_VERSION=$(curl -s https://api.github.com/repos/ros-infrastructure/ros-apt-source/releases/latest | grep -F "tag_name" | awk -F\" '{print $4}')
curl -L -o /tmp/ros2-apt-source.deb "https://github.com/ros-infrastructure/ros-apt-source/releases/download/${ROS_APT_SOURCE_VERSION}/ros2-apt-source_${ROS_APT_SOURCE_VERSION}.$(. /etc/os-release && echo $VERSION_CODENAME)_all.deb" # If using Ubuntu derivates use $UBUNTU_CODENAME
sudo dpkg -i /tmp/ros2-apt-source.deb
sudo apt update
sudo apt upgrade
sudo apt install ros-humble-desktop
sudo apt install ros-humble-ros-base
sudo apt install ros-dev-tools


ssh-keygen -t ed25519 -C "christo12aluckal@gmail.com"
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_ed25519

Color_Off='\033[0m'
Green='\033[0;32m'
echo -e "${Green}`cat ~/.ssh/id_ed25519.pub`${Color_Off}"

git config --global user.name "Christo Aluckal"
git config --global user.email "christo12aluckal@gmail.com"

read -p "Enter option (b/B for Bash of z/Z for Zsh): " user_input

case "$user_input" in
    b|B)
        echo "Configuring ROS Humble for bash..."
        touch ~/.bash_aliases
        # Append configurations to ~/.bashrc
        {
            echo ""
            echo "# ROS Humble setup"
            echo "source /opt/ros/humble/setup.bash"
            echo "source /usr/share/colcon_cd/function/colcon_cd.sh"
            echo "export _colcon_cd_root=/opt/ros/humble/"
            echo "source /usr/share/colcon_argcomplete/hook/colcon-argcomplete.bash"
        } >> ~/.bash_aliases

        echo "Setup added to ~/.bash_aliases. Reload with: source ~/.bashrc"
        ;;

    z|Z)
        echo "Configuring ROS Humble for zsh..."

        # Append configurations to ~/.zshrc
        {
            echo ""
            echo "# ROS Humble setup"
            echo "source /opt/ros/humble/setup.zsh"
            echo "source /usr/share/colcon_cd/function/colcon_cd.sh"
            echo "export _colcon_cd_root=/opt/ros/humble/"
            echo "source /usr/share/colcon_argcomplete/hook/colcon-argcomplete.zsh"
        } >> ~/.zshrc

        echo "eval \"$(register-python-argcomplete3 ros2)\"" >> ~/.zshrc
        eval "\"$(register-python-argcomplete3 colcon)\"" >> ~/.zshrc

        # --- Ensure completion is initialized ---
        echo "autoload -Uz compinit; compinit" >> ~/.zshrc
        echo "autoload -Uz +X bashcompinit; bashcompinit" >> ~/.zshrc

        # --- Argcomplete v2 for ros2/colcon ---
        echo "if command -v register-python-argcomplete3 >/dev/null; then" >> ~/.zshrc
        echo "  eval \"$(register-python-argcomplete3 ros2)\"" >> ~/.zshrc
        echo "  eval \"$(register-python-argcomplete3 colcon)\"" >> ~/.zshrc
        echo "fi" >> ~/.zshrc

        echo "Setup added to ~/.zshrc. Reload with: source ~/.zshrc"
        ;;

    *)
        echo "Invalid input. Use 'b' for bash or 'z' for zsh."
        ;;
esac

# --- Ensure completion is initialized ---
autoload -Uz compinit; compinit
autoload -Uz +X bashcompinit; bashcompinit

# --- Argcomplete v2 for ros2/colcon ---
if command -v register-python-argcomplete3 >/dev/null; then
  eval "$(register-python-argcomplete3 ros2)"
  eval "$(register-python-argcomplete3 colcon)"
fi


touch ~/.bash_aliases
echo "source /opt/ros/humble/setup.bash" >> ~/.bash_aliases
echo "source /usr/share/colcon_cd/function/colcon_cd.sh" >> ~/.bash_aliases
echo "export _colcon_cd_root=/opt/ros/humble/" >> ~/.bashrc
echo "source /usr/share/colcon_argcomplete/hook/colcon-argcomplete.bash" >> ~/.bash_aliases
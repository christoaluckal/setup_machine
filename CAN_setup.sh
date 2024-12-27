#!/bin/bash

if [ "$1" == "install" ]; then
    echo "Installing necessary packages."
    sudo apt update && sudo apt upgrade
    sudo apt install build-essential
    sudo apt install can-utils
    sudo apt install devmem2
    sudo apt install nano
    sudo apt install python3-pip
    pip3 install -U requests
elif [ "$1" == "can_setup" ]; then
    echo "Setting up CAN"
    sudo devmem2 0x0c303018 w 0x458
    sudo devmem2 0x0c303010 w 0x400
    sudo devmem2 0x0c303008 w 0x458
    sudo devmem2 0x0c303000 w 0x400
    sudo modprobe can
    sudo modprobe can_raw
    sudo modprobe mttcan
    sudo ip link set can0 down
    sudo ip link set can1 down
    sudo ip link set can0 type can bitrate 250000 berr-reporting on
    sudo ip link set can1 type can bitrate 250000 berr-reporting on
    sudo ip link set can0 up
    sudo ip link set can1 up
else
    echo "Invalid argument. Use 'install' or 'can_setup'."
fi
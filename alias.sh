#!/bin/bash

echo "\n----alias----"
aliases() {
  echo $'\nalias n="neofetch"\nalias k="uname -rs"\nalias g="gnome-shell --version"\nalias f="lsb_release -sd"\nalias m="inxi -G |grep Mesa"
  \nalias age="stat / | grep "Birth""\nalias ram="sudo dmidecode -t memory | grep Speed"\nalias cpu="lscpu | grep Model"
  \nalias cpuc="lscpu"\nalias w="wine --version"\nalias pc="inxi -Ixxx"\nalias net="inxi -Nxxx"' >> ~/.bashrc 
}
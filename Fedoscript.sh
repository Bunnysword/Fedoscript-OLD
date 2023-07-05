#!/bin/bash

echo -e "\t----Script for Fedora----"
echo -e "\t----On rpmfusion-non/free and appstream----" && sudo dnf install -y https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
sudo dnf in -y rpmfusion-free-appstream-data rpmfusion-nonfree-appstream-data
echo -e "\t----Boost dnf----" && sudo echo $'fastestmirror=True\nmax_parallel_downloads=10\ndefaultyes=True\nkeepcache=True' >> /etc/dnf/dnf.conf
sudo dnf autoremove -y && sudo dnf clean -y all && sudo dnf install -y dnf-automatic && systemctl enable dnf-automatic.timer
echo -e "\t----Yandex Browser----" && sudo rpmkeys --import https://repo.yandex.ru/yandex-browser/YANDEX-BROWSER-KEY.GPG && sudo dnf config-manager --add-repo http://repo.yandex.ru/yandex-browser/rpm/stable/x86_64 && sudo dnf install yandex-browser-stable -y
echo -e "\t----Remove native apps----" && sudo dnf remove -y mediawriter rhythmbox evince yelp gnome-characters gnome-logs totem gnome-tour gnome-photos gnome-maps gnome-weather gnome-font-viewer gnome-contacts gnome-clocks gnome-calendar gnome-boxes firefox libreoffice*
echo -e "\t----Install native apps----" && sudo dnf install -y mangohud timeshift goverlay steam lutris transmission-gtk telegram-desktop kdenlive vlc gnome-tweaks htop redhat-lsb-core rocm-opencl inxi neofetch protontricks --allowerasing
echo -e "\t----installing codecs----" && sudo dnf install -y gstreamer1-plugins-{bad-\*,good-\*,base} gstreamer1-plugin-openh264 gstreamer1-libav --exclude=gstreamer1-plugins-bad-free-devel
sudo dnf install lame\* --exclude=lame-devel && sudo dnf group upgrade --with-optional Multimedia --allowerasing
echo -e "\t----On flatpak----" && flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
echo -e "\t----Install flatpak apps----" && flatpak install -y flathub com.heroicgameslauncher.hgl com.obsproject.Studio com.mattjakeman.ExtensionManager
echo -e "\t----Kernel-Xanmod-edge----" && sudo dnf copr enable -y guara/kernel-xanmod && sudo dnf in -y kernel-xanmod-edge*
echo -e "\t----configuring firewall----"
sudo firewall-cmd --zone=public --permanent --add-port=1714-1764/tcp && sudo firewall-cmd --zone=public --permanent --add-port=1714-1764/udp && sudo systemctl restart firewalld.service
echo -e "\t----Upgrade----" && sudo dnf upgrade -y --refresh
echo -e "\t----Clean----" && sudo dnf clean all


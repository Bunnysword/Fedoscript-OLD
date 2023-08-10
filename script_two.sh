#!/bin/bash

#Fast_DNF
echo -e "\tFast DNF" && sudo sh -c "echo -e 'fastestmirror=True\nmax_parallel_downloads=10\ndefaultyes=True\nkeepcache=True' >> /etc/dnf/dnf.conf" -y
sudo dnf autoremove -y && sudo dnf clean all -y && sudo dnf install dnf-automatic -y && systemctl enable dnf-automatic.timer -y

#Repo rpm
echo -e "\tRepo rpm" && sudo dnf install https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm -y
sudo dnf in rpmfusion-free-appstream-data rpmfusion-nonfree-appstream-data -y

echo -e "\tCopr"

#NoiseTorch
echo -e "\tNoiseTorch" && sudo dnf copr enable principis/NoiseTorch -y && sudo dnf install noisetorch -y

#kernel-cachyos
echo -e "\tkernel-cachyos" && sudo setsebool -P domain_kernel_load_modules on -y && sudo dnf copr enable bieszczaders/kernel-cachyos -y && sudo dnf install kernel-cachyos-bore -y
sudo dnf copr enable bieszczaders/kernel-cachyos-addons -y && sudo dnf in uksmd ananicy-cpp bore-sysctl -y && sudo systemctl enable uksmd ananicy-cpp -y

#Y.repo
echo -e "\tY.repo" && sudo rpmkeys --import https://repo.yandex.ru/yandex-browser/YANDEX-BROWSER-KEY.GPG -y
sudo dnf config-manager --add-repo http://repo.yandex.ru/yandex-browser/rpm/stable/x86_64 -y && sudo dnf install yandex-browser-stable -y

#Flathub
echo -e "\tFlathub" && flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo -y && flatpak install flathub com.heroicgameslauncher.hgl com.obsproject.Studio com.mattjakeman.ExtensionManager -y

#Codecs
echo -e "\tCodecs" && sudo dnf install gstreamer1-plugins-{bad-\*,good-\*,base} gstreamer1-plugin-openh264 gstreamer1-libav --exclude=gstreamer1-plugins-bad-free-devel -y
sudo dnf install lame\* --exclude=lame-devel -y && sudo dnf group upgrade Multimedia --with-optional --allowerasing -y

#Services
echo -e "\tOFF_Services" && sudo systemctl disable plymouth-quit-wait.service dmraid-activation.service livesys-late.service disable livesys.service rpcbind.service lvm2-monitor.service

#Remove_apps
echo -e "\tRemove apps" && sudo dnf remove mediawriter rhythmbox evince yelp gnome-characters gnome-logs totem gnome-tour gnome-photos gnome-maps gnome-weather gnome-font-viewer gnome-contacts gnome-clocks gnome-calendar gnome-boxes firefox libreoffice* -y

#Install_apps
echo -e "\tInstall Apps" && sudo dnf install mangohud timeshift goverlay steam lutris transmission-gtk kdenlive vlc gnome-tweaks htop redhat-lsb-core rocm-opencl inxi neofetch protontricks --allowerasing -y

#Papirus icon
echo -e "\tPapirus icons"
sudo dnf install papirus-icon-theme -y

#Papirus folders
echo -e "\tPapirus folders" && wget -qO- https://git.io/papirus-folders-install | sh -y && papirus-folders -C violet --theme Papirus-Dark -y

#Upgrade
echo -e "\t----Upgrade----" && sudo dnf upgrade --refresh -y
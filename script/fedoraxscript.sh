#!/bin/bash

echo -e "\t----Script for Fedora----"
echo -e "\t----On rpmfusion-non/free and appstream----" && sudo dnf install -y https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
sudo dnf in -y rpmfusion-free-appstream-data rpmfusion-nonfree-appstream-data
echo -e "\t----Boost dnf----" && sudo echo $'fastestmirror=True\nmax_parallel_downloads=10\ndefaultyes=True\nkeepcache=True' >> /etc/dnf/dnf.conf
sudo dnf autoremove -y && sudo dnf clean -y all && sudo dnf install -y dnf-automatic && systemctl enable dnf-automatic.timer
echo -e "\t----Yandex Browser----" && sudo rpmkeys --import https://repo.yandex.ru/yandex-browser/YANDEX-BROWSER-KEY.GPG && sudo dnf config-manager --add-repo http://repo.yandex.ru/yandex-browser/rpm/stable/x86_64 && sudo dnf install yandex-browser-stable -y
echo -e "\t----Remove native apps----" && sudo dnf remove -y mediawriter rhythmbox evince yelp gnome-characters gnome-logs totem gnome-tour gnome-photos gnome-maps gnome-weather gnome-font-viewer gnome-contacts gnome-clocks gnome-calendar gnome-boxes firefox libreoffice*
echo -e "\t----Install native apps----" && sudo dnf install -y discord mangohud timeshift goverlay steam lutris transmission-gtk telegram-desktop kdenlive vlc gnome-tweaks htop redhat-lsb-core rocm-opencl inxi neofetch protontricks --allowerasing
echo -e "\t----installing codecs----" && sudo dnf install -y gstreamer1-plugins-{bad-\*,good-\*,base} gstreamer1-plugin-openh264 gstreamer1-libav --exclude=gstreamer1-plugins-bad-free-devel
sudo dnf install lame\* --exclude=lame-devel && sudo dnf group upgrade --with-optional Multimedia

echo -e "\t----On flatpak----" && flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
echo -e "\t----Install flatpak apps----" && flatpak install -y flathub com.heroicgameslauncher.hgl com.obsproject.Studio com.mattjakeman.ExtensionManager
echo -e "\t----Kernel-Xanmod-edge----" && sudo dnf copr enable -y guara/kernel-xanmod && sudo dnf in -y kernel-xanmod-edge
echo -e "\t----Upgrade----" && sudo dnf upgrade -y --refresh
echo -e "\t----Clean----" && sudo dnf clean all
echo -e "\t----Off Services-----"
systemctl --user mask org.gnome.SettingsDaemon.Wacom.service
systemctl --user mask org.gnome.SettingsDaemon.Color.service
systemctl --user mask org.gnome.SettingsDaemon.UsbProtection.service
systemctl --user mask org.gnome.SettingsDaemon.Smartcard.service
echo "\n----alias----" && alias n="neofetch" && alias n="neofetch" && alias k="uname -rs" && alias g="gnome-shell --version" && alias f="lsb_release -sd" 
alias m="inxi -G |grep Mesa" && alias age="stat / | grep "Birth"" && alias ram="sudo dmidecode -t memory | grep Speed"
alias cpu="lscpu | grep Model" && alias cpuc="lscpu" && alias w="wine --version" && alias pc="inxi -Ixxx" && alias net="inxi -Nxxx"

echo -e "\t----Extensions Gnome----" && gnome-extensions enable appindicatorsupport@rgcjonas.gmail.com 
array=( https://extensions.gnome.org/extension/1160/dash-to-panel/
https://extensions.gnome.org/extension/4679/burn-my-windows/
https://extensions.gnome.org/extension/3193/blur-my-shell/
https://extensions.gnome.org/extension/1319/gsconnect/
https://extensions.gnome.org/extension/5237/rounded-window-corners/
https://extensions.gnome.org/extension/1228/arc-menu/
)
for i in "${array[@]}"
do
    EXTENSION_ID=$(curl -s $i | grep -oP 'data-uuid="\K[^"]+')
    VERSION_TAG=$(curl -Lfs "https://extensions.gnome.org/extension-query/?search=$EXTENSION_ID" | jq '.extensions[0] | .shell_version_map | map(.pk) | max')
    wget -O ${EXTENSION_ID}.zip "https://extensions.gnome.org/download-extension/${EXTENSION_ID}.shell-extension.zip?version_tag=$VERSION_TAG"
    gnome-extensions install -y --force ${EXTENSION_ID}.zip
    if ! gnome-extensions list | grep --quiet ${EXTENSION_ID}; then
        busctl --user call org.gnome.Shell.Extensions /org/gnome/Shell/Extensions org.gnome.Shell.Extensions InstallRemoteExtension s ${EXTENSION_ID}
    fi
    gnome-extensions enable ${EXTENSION_ID}
    rm ${EXTENSION_ID}.zip
done
echo -e "\t----configuring firewall----"
sudo firewall-cmd --zone=public --permanent --add-port=1714-1764/tcp && sudo firewall-cmd --zone=public --permanent --add-port=1714-1764/udp && sudo systemctl restart firewalld.service


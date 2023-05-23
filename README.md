Script for Fedora 37(38)

in terminal:
wget https://github.com/Bunnysword/FedoraXScript/raw/main/script/fedoraxscript.sh && sh fedoraxscript.sh

On rpmfusion free/nonfree, yandex-browser repo.

off services: 
systemctl --user mask org.gnome.SettingsDaemon.Wacom.service
systemctl --user mask org.gnome.SettingsDaemon.Color.service
systemctl --user mask org.gnome.SettingsDaemon.UsbProtection.service
systemctl --user mask org.gnome.SettingsDaemon.Smartcard.service

extensions gnome:
https://extensions.gnome.org/extension/1160/dash-to-panel/
https://extensions.gnome.org/extension/4679/burn-my-windows/
https://extensions.gnome.org/extension/3193/blur-my-shell/
https://extensions.gnome.org/extension/1319/gsconnect/
https://extensions.gnome.org/extension/5237/rounded-window-corners/
https://extensions.gnome.org/extension/1228/arc-menu/

install kernel xanmod:
https://copr.fedorainfracloud.org/coprs/guara/kernel-xanmod/ (guara/kernel-xanmod)

install flatpak apps:
flathub com.heroicgameslauncher.hgl com.obsproject.Studio com.mattjakeman.ExtensionManager
remove rpm-apps:
mediawriter rhythmbox evince yelp gnome-characters gnome-logs totem gnome-tour gnome-photos gnome-maps gnome-weather gnome-font-viewer gnome-contacts gnome-clocks gnome-calendar gnome-boxes firefox libreoffice*
install rpm-apps:
discord mangohud timeshift goverlay steam lutris transmission-gtk telegram-desktop kdenlive vlc gnome-tweaks htop redhat-lsb-core rocm-opencl inxi neofetch protontricks

alias:
alias n="neofetch" && alias n="neofetch"
alias k="uname -rs" && alias g="gnome-shell --version"
alias f="lsb_release -sd" && alias m="inxi -G |grep Mesa"
alias age="stat / | grep "Birth"" && alias ram="sudo dmidecode -t memory | grep Speed"
alias cpu="lscpu | grep Model" && alias cpuc="lscpu"
alias w="wine --version" && alias pc="inxi -Ixxx" && alias net="inxi -Nxxx"

and more

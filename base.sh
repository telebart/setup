#!/bin/bash


sudo pacman -S --needed \
    libxpm xorg-server xorg-apps xorg-xinit xorg-xmessage libx11 libxft libxinerama libxrandr libxss pkgconf \
    lxsession trayer rofi alacritty xwallpaper ripgrep base-devel

git clone https://github.com/xmonad/xmonad
git clone https://github.com/xmonad/xmonad-contrib
git clone https://github.com/jaor/xmobar

curl -sSL https://get.haskellstack.org/ | sh
stack init

git clone https://aur.archlinux.org/paru.git
cd paru
makepkg -si

paru -S rate-mirrors lf

#sudo pacman -S --needed wine-staging giflib lib32-giflib libpng lib32-libpng libldap lib32-libldap gnutls lib32-gnutls \
#mpg123 lib32-mpg123 openal lib32-openal v4l-utils lib32-v4l-utils libpulse lib32-libpulse libgpg-error \
##lib32-libgpg-error alsa-plugins lib32-alsa-plugins alsa-lib lib32-alsa-lib libjpeg-turbo lib32-libjpeg-turbo \
#sqlite lib32-sqlite libxcomposite lib32-libxcomposite libxinerama lib32-libgcrypt libgcrypt lib32-libxinerama \
#ncurses lib32-ncurses opencl-icd-loader lib32-opencl-icd-loader libxslt lib32-libxslt libva lib32-libva gtk3 \
#lib32-gtk3 gst-plugins-base-libs lib32-gst-plugins-base-libs vulkan-icd-loader lib32-vulkan-icd-loader

#sudo pacman -S --needed lib32-mesa vulkan-radeon lib32-vulkan-radeon vulkan-icd-loader lib32-vulkan-icd-loader \
    #gamemode lib32-gamemode

echo vm.max_map_count=2147483642 > /etc/sysctl.d/90-override.conf

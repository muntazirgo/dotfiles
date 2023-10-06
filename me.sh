#!/usr/bin/env bash
# Color Escape Sequences
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;93m'
BOLD='\033[1m'
RESET='\033[0m'

# Absolute path to the commands used in this script

echo () {
    /usr/bin/echo -e "$@"
}

# Installing Packages
echo "${RED}${BOLD}Installing xbps${RESET}"
xbps-install -Sy xbps
echo "${RED}${BOLD}Updating the system${RESET}"
xbps-install -Syu
declare -a PKGS=(sddm qt5-declarative qt5-graphicaleffects qt5-quickcontrols qt5-quickcontrols2 \
        qt5-svg xorg polkit elogind xfce-polkit NetworkManager NetworkManager-l2tp NetworkManager-openconnect \
        NetworkManager-openvpn NetworkManager-pptp NetworkManager-strongswan NetworkManager-vpnc network-manager-applet \
        bluez blueman cups cups-filters cups-pdf ghostscript foomatic-db foomatic-db-engine gsfonts gutenprint \
        gvfs gvfs-afc gvfs-afp gvfs-cdda gvfs-gphoto2 gvfs-mtp gvfs-smb udiskie udisks2 ffmpegthumbnailer highlight \
        trash-cli tumbler ueberzug xdg-user-dirs xdg-user-dirs-gtk thunar-archive-plugin thunar-media-tags-plugin thunar-volman \
        pipewire wireplumber pavucontrol alsa-pipewire alsa-plugins-jack alsa-plugins-pulseaudio libde256 libmpeg2 libtheora libvpx \
        x264 x265 xvideocore gstreamurl ffmpeg gst-libav gst-plugins-good1 gst-plugins-bad1 gst-plugins-ugly1 mesa-vaapi mesa-vdpan \
        jasper libwebp libavif libheif noto-fonts-ttf noto-fonts-emoji noto-fonts-ttf-extra openbox obmenu-generator perl-Linux-DesktopFiles \
        plank tint2 xmlstarlet xfce4-terminal xfce4-settings bspwm sxkhd feh xsettingsd alacritty qutebrowser firefox geany geany-plugins Thunar \
        viewnior atril htop nethogs ncdu powertop ranger neovim pzip2 gzip lrzip lz4 lzip lzop p2zip unzip xz xarchiver zstd zip kvantum qt5ct curl \
        git inetutils wget mpc mpd ncmpcpp mplayer pulsemixer neofetch wireless_tools betterlockscreen dunst ksuperkey nitrogen pastel picom polybar \
        pywal rofi maim slop acpi light xfce4-power-manager arandr bc dialog galculator gparted gtk3-nocsd gtk-engine-murrine gnome-keyring inotify-tools \
    jq meld psmisc sound-theme-freedesktop wmctrl wmname xclip xcolor xdotool yad nano zsh)

for i in ${PKGS[@]}; do
    echo "\n${RED}${BOLD}Installing ${i}${RESET}"
    xbps-install -y "${i}"
done

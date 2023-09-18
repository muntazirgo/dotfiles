#!/usr/bin/env bash

# Color Escape Sequences
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;93m'
BOLD='\033[1m'
RESET='\033[0m'

# Absolute path to the commands used in this script
ln () {
    /usr/bin/ln -sv "$@"
}

echo () {
    /usr/bin/echo -e "$@"
}
mv () {
    /usr/bin/mv -v "$@"
}

# Asks the user if he wants to backup the old dotfiles or not
echo "${RED}${BOLD}Do you want to backup the old dotfiles? (Y/n) \c"
# reading the user input
read backup

# The files to be stored and linked
declare -a home=( $(command ls -A "$HOME/.dotfiles/home/") )
declare -a dotconfig=( $(command ls -A "$HOME/.dotfiles/config/") )

# checking the user input
case $backup in
        # if the user typed yes or y or just pressed enter
    ""|[Yy]|[Yy][Ee][Ss])
        # $HOME dotfiles
        for i in ${home[@]}; do
            if [[ ! -f "$HOME/${i}" && ! -d "$HOME/${i}" ]]; then
                echo "\n${GREEN}${BOLD}Linking ${i}${RESET}"
                ln "$HOME/.dotfiles/home/${i}" "$HOME"
            elif [[ ! -L "$HOME/${i}" && -f "$HOME/${i}" ]]; then
                echo "\n${GREEN}${BOLD}Linking ${i}${RESET}"
                mv "$HOME/${i}" "$HOME/${i}_backup"
                ln "$HOME/.dotfiles/home/${i}" "$HOME"
            fi
        done

        # $HOME/.config dotfiles
        for i in ${dotconfig[@]}; do
            if [[ ! -f "$HOME/.config/${i}" && ! -d "$HOME/.config/${i}" ]]; then
                echo "\n${GREEN}${BOLD}Linking ${i}${RESET}"
                ln "$HOME/.dotfiles/config/${i}" "$HOME/.config"
            elif [[ ! -L "$HOME/.config/${i}" && -f "$HOME/.config/${i}" ]]; then
                echo "\n${GREEN}${BOLD}Linking ${i}${RESET}"
                mv "$HOME/.config/${i}" "$HOME/.config/${i}_backup"
                ln "$HOME/.dotfiles/config/${i}" "$HOME/.config"
            fi
        done
        ;;
        # if the user typed no or n
    [Nn]|[Nn][Oo])
        # $HOME dotfiles
        for i in ${home[@]}; do
            echo "\n${GREEN}${BOLD}Linking ${i}${RESET}"
            ln -f "$HOME/.dotfiles/home/${i}" "$HOME"
        done

        # $HOME/.config dotfiles
        for i in ${dotconfig[@]}; do
            echo "\n${GREEN}${BOLD}Linking ${i}${RESET}"
            ln -f "$HOME/.dotfiles/config/${i}" "$HOME/.config"
        done
        ;;
        # if the user typed anything else
    *)
        echo "Invalid Choice"
        exit 1
        ;;
esac

# installing neovim config
command -v git >/dev/null 2>&1
if [[ $? -ne 0 ]]; then
    sudo xbps-install -S git
else
    if [[ ! -d "$HOME/.config/nvim" ]]; then
        git clone https://github.com/muntazirgo/astronvim_config.git "$HOME/.config/nvim"
    else
        echo "\n${GREEN}${BOLD}NEOVIM"
        echo "\n${GREEN}${BOLD}${HOME}/.config/nvim/ exists!"
        echo "${GREEN}${BOLD}Remove it and run the script again if you want to clone the configs from github"
    fi
fi

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
# checking the user input
declare -a bash=( $(command ls -A "$HOME/.dotfiles/home/") )
declare -a dotconfig=( $(command ls -A "$HOME/.dotfiles/config/") )
case $backup in
        # if the user typed yes or y or just pressed enter
    ""|[Yy]|[Yy][Ee][Ss])
        # $HOME dotfiles
        for i in ${bash[@]}; do
            if [[ ! -f "$HOME/${i}" ]]; then
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
            if [[ ! -f "$HOME/.config/${i}" ]]; then
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
        for i in ${bash[@]}; do
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
# #
# # #
# # # checking for some packages
# # # packages=(fzf nvim fzy)
# # # for i in ${packages[@]}; do
# # #     command -v "${i}" >/dev/null 2>&1
# # #     if [[ $? -eq 0 ]]; then
# # #         echo "Git command found"
# # #     else
# # #         echo "Git command not found"
# # #         # echo "${RED}${BOLD}Installing fzf${RESET}"
# # #         # sudo xbps-install -y fzf
# # #     fi
# # # done

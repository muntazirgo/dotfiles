#!/usr/bin/env bash

DIR="$HOME/.config/alacritty/colorschemes"
cd "${DIR}" || exit
chosen_colorscheme=$(fzf --border=rounded --prompt=' ' --pointer='ﲖ' --preview "bat --theme=OneHalfDark --color=always {}")

function set_colorscheme() {
	previous_colorscheme="$HOME/.config/alacritty/colors.yml"
	new_colorscheme="$HOME/.config/alacritty/colorschemes/${chosen_colorscheme}"
	DIR="$HOME/.config/alacritty/"
	if [ -f "${previous_colorscheme}" ]; then
		rm -rf "${previous_colorscheme}"
		cp -r "${new_colorscheme}" "${DIR}/colors.yml"
	else
		cp -r "${new_colorscheme}" "${DIR}/colors.yml"
	fi
}
set_colorscheme

# ------------------------------------------------------------------------------
# Copyright (C) 2020-2023 Aditya Shakya <adi1090x@gmail.com>
#
# Adaptive Theme
# ------------------------------------------------------------------------------

# Colors
background='#1d1f28'
foreground='#fdfdfd'
color0='#282a36'
color1='#f37f97'
color2='#5adecd'
color3='#f2a272'
color4='#8897f4'
color5='#c574dd'
color6='#79e6f3'
color7='#fdfdfd'
color8='#414458'
color9='#ff4971'
color10='#26CDB8'
color11='#ff8037'
color12='#556fff'
color13='#b043d1'
color14='#3fdcee'
color15='#bebec1'

accent='#00BCD4'
light_value='0.15'
dark_value='0.30'

# Wallpaper
wdir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
wallpaper="$wdir/wallpaper"

# Polybar
polybar_font='Iosevka Nerd Font:size=11;3'

# Rofi
rofi_font='Iosevka 11'
rofi_icon='Papirus-Apps'

# Terminal
terminal_font_name='JetBrainsMono Nerd Font'
terminal_font_size='13'

# Geany
geany_colors='adapta.conf'
geany_font='JetBrains Mono 13'

# Appearance
gtk_font='Noto Sans 10'
gtk_theme='Adapta-Nokto'
icon_theme='Luv-Folders-Dark'
cursor_theme='Vimix'

# Dunst
dunst_width='300'
dunst_height='80'
dunst_offset='10x44'
dunst_origin='top-right'
dunst_font='Iosevka Custom 11'
dunst_border='1'
dunst_separator='1'

# Picom
picom_backend='glx'
picom_corner='0'
picom_shadow_r='14'
picom_shadow_o='0.30'
picom_shadow_x='-12'
picom_shadow_y='-12'
picom_blur_method='none'
picom_blur_strength='0'

# Bspwm
bspwm_fbc="$accent"
bspwm_nbc="$background"
bspwm_abc="$color5"
bspwm_pfc="$color2"
bspwm_border='1'
bspwm_gap='10'
bspwm_sratio='0.50'

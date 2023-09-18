#!/usr/bin/env bash

# Color Escape  Sequences
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;93m'
BOLD='\033[1m'
RESET='\033[0m' # No Color

# Absolute Path To Commands Used In This Script
echo="/usr/bin/echo -e"
ls="/usr/bin/ls"
sed="/usr/bin/sed"
cat="/usr/bin/cat"

# Absolute Path To Directories And Files Used In This Script
zathura_themes="/$HOME/.config/zathura/themes"

# A heading
$echo "\n${RED}${BOLD}Choose the colorscheme to be applied:\n${RESET}"

# Displaying the themes for the user
iter=1
for i in $($ls ${zathura_themes}); do
    $echo "    ${BOLD}[$iter]${RESET} $i"
    let iter++
done

# Getting the user choice
$echo "\n${GREEN}${BOLD}Choose: ${RESET}\c"
read theme

## Checking the user choice and making sure it is valid
# Pattern to match only numbers
pattern="^[0-9]+$"

if [[ $theme =~ $pattern ]] && [[ $theme -le $(($iter-1)) ]] && [[ $theme -gt "0" ]]; then
    selected_theme=$($ls ./themes | $sed -n ${theme}p)

    $cat "$zathura_themes/$selected_theme" > "./zathurarc"

    $echo "\n${YELLOW}${BOLD}Applying ${selected_theme}...\c"
    sleep 0.5
    echo " Done!"
else
    echo "Invalid choice. Please enter a valid number." >&2
    exit 1
fi

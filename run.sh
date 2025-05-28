#!/bin/bash

RED='\e[1;91m'
GREEN='\e[1;92m'
BLUE='\e[1;94m'
ORANGE='\e[1;93m'
NO_COLOR='\e[0m'

source ./scripts/aptitude.sh
source ./scripts/flatpak.sh
source ./scripts/gnomeExtensions.sh
source ./scripts/shell.sh
source ./scripts/asdf.sh
source ./customization/customize.sh

echo -e "${ORANGE}This step will update system and clean caches${NO_COLOR}"
read -p "Continue? (Y/N): " confirm && [[ $confirm == [yY] || $confirm == [yY][eE][sS] ]] || exit 1
upgrade_cleanup

echo -e "${ORANGE}Next step will remove unsude apps${NO_COLOR}"
read -p "Continue? (Y/N): " confirm && [[ $confirm == [yY] || $confirm == [yY][eE][sS] ]] || exit 1
remove_unused_apps

echo -e "${ORANGE}Next step will install apt packages${NO_COLOR}"
read -p "Continue? (Y/N): " confirm && [[ $confirm == [yY] || $confirm == [yY][eE][sS] ]] || exit 1
install_deb_apps

echo -e "${ORANGE}Next step will install flatpak and apps${NO_COLOR}"
read -p "Continue? (Y/N): " confirm && [[ $confirm == [yY] || $confirm == [yY][eE][sS] ]] || exit 1
install_flatpak_apps

echo -e "${ORANGE}Next step will install gnome extensions${NO_COLOR}"
read -p "Continue? (Y/N): " confirm && [[ $confirm == [yY] || $confirm == [yY][eE][sS] ]] || exit 1
install_gnome_extensions

echo -e "${ORANGE}Next step will config is zsh${NO_COLOR}"
read -p "Continue? (Y/N): " confirm && [[ $confirm == [yY] || $confirm == [yY][eE][sS] ]] || exit 1
configure_shell

# Needs to reload shell to run
echo -e "${ORANGE}Next step will config is asdf vm${NO_COLOR}"
read -p "Continue? (Y/N): " confirm && [[ $confirm == [yY] || $confirm == [yY][eE][sS] ]] || exit 1
configure_asdf

echo -e "${ORANGE}Next step will config font, icons, themes, cursor and wallpapers${NO_COLOR}"
read -p "Continue? (Y/N): " confirm && [[ $confirm == [yY] || $confirm == [yY][eE][sS] ]] || exit 1
apply_custom

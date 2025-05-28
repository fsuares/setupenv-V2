#!/bin/bash

RED='\e[1;91m'
GREEN='\e[1;92m'
BLUE='\e[1;94m'
ORANGE='\e[1;93m'
NO_COLOR='\e[0m'

configure_shell(){
	# ASDF
	git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.14.1
	echo -e "${BLUE}[ASDF] - Installed ${NO_COLOR}"
	sleep 1
	echo
	echo

	# Starship
	curl -sS https://starship.rs/install.sh | sh
	echo -e "${BLUE}[Starship] - Installed ${NO_COLOR}"
	sleep 1
	echo
	echo

	# Antigen
	curl -L git.io/antigen > $HOME/.antigen.zsh
	echo -e "${BLUE}[Antigen] - Installed ${NO_COLOR}"
	sleep 1
	echo
	echo

	# Nerdfetch
	sudo curl -fsSL https://raw.githubusercontent.com/ThatOneCalculator/NerdFetch/main/nerdfetch -o /usr/bin/nerdfetch
	sudo chmod +x /usr/bin/nerdfetch
	echo -e "${BLUE}[Nerdfetch] - Installed"
	sleep 1
	echo
	echo

	# ZSHRC
	cp ./.dotfiles/.zshrc $HOME/
	echo -e "${ORANGE}[ZSHRC] - Copied do home ${NO_COLOR}"
	sleep 1
	echo
	echo

	# WEZTERM
	cp ./.dotfiles/ghostty -r $HOME/.config/
	echo -e "${ORANGE}[GHOSTTY CONFIG] - Copied to .config ${NO_COLOR}"
	sleep 1
	echo
	echo
}

export configure_shell

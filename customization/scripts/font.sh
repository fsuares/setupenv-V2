#!/bin/bash

install_fonts(){
	mkdir $HOME/.local/share/fonts
	cp -r ./.dotfiles/fonts/* $HOME/.local/share/fonts

	wget -O JetBrainsMono.zip "https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/JetBrainsMono.zip"
	unzip JetBrainsMono.zip -d ~/.local/share/fonts/JetBrainsMono
	rm JetBrainsMono.zip

	git clone https://github.com/ryanoasis/nerd-fonts.git
	./nerd-fonts/install.sh
	rm -rf nerd-fonts

	fc-cache -fv
	gsettings set org.gnome.desktop.interface font-name 'Roboto Regular 10'
	gsettings set org.gnome.desktop.interface monospace-font-name 'JetBrainsMono Nerd Font Regular 11'
	gsettings set org.gnome.desktop.interface document-font-name 'Roboto Regular 11'
}

export install_fonts
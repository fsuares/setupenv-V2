#!/bin/bash

install_gtk_theme(){
	git clone https://github.com/vinceliuice/WhiteSur-gtk-theme.git

	./WhiteSur-gtk-theme/install.sh -c dark -o solid
	sudo rm -rf WhiteSur-gtk-theme

	sudo cp -r $HOME/.themes/* /usr/share/themes

	gsettings set org.gnome.desktop.interface gtk-theme "WhiteSur-Dark-solid"
	gsettings set org.gnome.desktop.wm.preferences theme "WhiteSur-Dark-solid"

	# Setting theme icons to flatpak apps
	sudo flatpak override --filesystem=$HOME/.themes
	sudo flatpak override --filesystem=$HOME/.icons
	flatpak override --user --filesystem=xdg-config/gtk-4.0
	sudo flatpak override --filesystem=xdg-config/gtk-4.0
}

change_wallpaper(){
	sudo cp -r ./.dotfiles/wallpapers /usr/share/backgrounds/
	gsettings set org.gnome.desktop.background picture-uri file:///usr/share/backgrounds/wallpapers/124.jpg
	gsettings set org.gnome.desktop.background picture-uri-dark file:///usr/share/backgrounds/wallpapers/124.jpg
}

export change_wallpaper
export install_gtk_theme
Compact
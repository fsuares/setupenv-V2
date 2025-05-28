#!/bin/bash

source ./customization/scripts/font.sh
source ./customization/scripts/icon.sh
source ./customization/scripts/theme.sh

apply_custom(){
	# Change the Wallpaper
	change_wallpaper

	# Intall and applyGTK Theme
	install_gtk_theme

	# Install and apply Icons
	install_icons

	# Install and apply Cursor
	install_cursor

	# Install fonts
	install_fonts
}

export apply_custom

#!/bin/bash

RED='\e[1;91m'
GREEN='\e[1;92m'
BLUE='\e[1;94m'
ORANGE='\e[1;93m'
NO_COLOR='\e[0m'

install_flatpak_apps(){
	FLATPAK_APPS=(
		'com.discordapp.Discord'
		'com.gigitux.youp'
		'com.github.IsmaelMartinez.teams_for_linux'
		'com.jetbrains.WebStorm'
		'com.mattermost.Desktop'
		'com.mattjakeman.ExtensionManager'
		'com.spotify.Client'
		'com.usebruno.Bruno'
		'dev.zed.Zed'
		'io.github.realmazharhussain.GdmSettings'
		'md.obsidian.Obsidian'
		'org.gnome.Polari'
		'org.gtk.Gtk3theme.Pop-dark'
		're.sonny.Commit'
		'org.chromium.Chromium'
		'org.mozilla.Thunderbird'
		'io.beekeeperstudio.Studio'
		'com.jetbrains.IntelliJ-IDEA-Community'
		'com.bitwarden.desktop'
	)


  # Add Flathub repository
  if ! flatpak remote-list | grep -q "flathub"; then
    echo -e "${GREEN}[INFO] - Installing Flathub...${NO_COLOR}"
    sudo apt install flatpak -y &> /dev/null
    echo -e "${GREEN}[INFO] - Adding Flathub repository...${NO_COLOR}"
    flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
  else
    echo -e "${ORANGE}[INFO] - Flathub repository is already added.${NO_COLOR}"
  fi
	sleep 1
	echo
	echo

  # Install flatpak apps
  for PKG in ${FLATPAK_APPS[@]}; do
    if ! flatpak list | grep -q $PKG; then
          echo -e "${GREEN}[INFO] - Installing $PKG...${NO_COLOR}"
      flatpak install flathub $PKG -y
    else
      echo -e "${ORANGE}[INFO] - $PKG flatpak is already installed.${NO_COLOR}"
    fi
  done
	sleep 1
	echo
	echo
}

export install_flatpak_apps

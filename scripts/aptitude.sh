#!/bin/bash

RED='\e[1;91m'
GREEN='\e[1;92m'
BLUE='\e[1;94m'
ORANGE='\e[1;93m'
NO_COLOR='\e[0m'

remove_unused_apps(){
	APPS=(
		'firefox'
		'libreoffice'
		'libreoffice-math'
		'libreoffice-writer'
		'libreoffice-draw'
		'libreoffice-impress'
		'libreoffice-calc'
		'geary'
		'gnome-contacts'
		'gedit'
	)
	for APP in ${APPS[@]}; do
		if dpkg -l | grep -q $APP; then # Só instala se já não estiver instalado
		  sudo apt remove "$APP" -y
		  echo -e "${GREEN}[SUCESS] - Uninstalled $APP ${NO_COLOR}"
		else
		  echo -e "${ORANGE}[NOT INSTALED] - $APP ${NO_COLOR}"
		fi
	done
	sleep 1
	echo
	echo
}

upgrade_cleanup () {
  echo -e "[INFO] - Performing upgrade and cleanup..."
  sleep 1
  sudo rm -rf /var/lib/dpkg/lock
  sudo rm -rf /var/lib/dpkg/lock-frontend
  sudo rm -rf /var/cache/apt/archives/lock
  sudo apt autoclean
  sudo apt clean
  sudo apt update -m
  sudo dpkg --configure -a
  sudo apt install -f
  sudo apt full-upgrade
  sudo apt autoremove -y
  sleep 1
	echo
	echo
}

install_deb_apps(){
	DEB_PKGS=(
		'apt-transport-https'
		'software-properties-common'
		'bashtop'
		'bat'
		'ca-certificates'
		'cpp'
		'curl'
		'code'
		'containerd.io'
		'dconf-cli'
		'docker-buildx-plugin'
		'docker-ce'
		'docker-ce-cli'
		'docker-ce-rootless-extras'
		'docker-compose-plugin'
		'exa'
		'flatpak'
		'folder-color'
		'g++'
		'gcc'
		'ghostscript'
		'ghostscript-x'
		'git'
		'gnome-sushi'
		'gnome-tweaks'
		'gparted'
		'gtk2-engines-murrine'
		'libbz2-dev'
		'libffi-dev'
		'libncurses5-dev'
		'libreadline-dev'
		'libsqlite3-dev'
		'libssl-dev'
		'repoman'
		'sassc'
		'snap'
		'snapd'
		'trash-cli'
		'vlc'
		'wget'
		'xclip'
		'zlib1g'
		'zlib1g-dev'
		'zsh'
		'exa'
	)

	wget -O vscode.deb "https://code.visualstudio.com/sha/download?build=stable&os=linux-deb-x64"
	if ! dpkg -l | grep -q code; then
		echo -e "${GREEN}[INFO] - Installing Visual Studio Code...${NO_COLOR}"
		sudo dpkg -i vscode.deb
		rm vscode.deb
	else
		echo -e "${ORANGE}[INFO] - Visual Studio Code is already installed.${NO_COLOR}"
	fi

	wget https://github.com/mkasberg/ghostty-ubuntu/releases/download/1.1.3-0-ppa2/ghostty_1.1.3-0.ppa2_amd64_22.04.deb
	if ! dpkg -l | grep -q ghostty; then
		echo -e "${GREEN}[INFO] - Installing Ghostty...${NO_COLOR}"
		sudo dpkg -i ghostty_1.1.3-0.ppa2_amd64_22.04.deb
		rm ghostty_1.1.3-0.ppa2_amd64_22.04.deb
	else
		echo -e "${ORANGE}[INFO] - Ghostty is already installed.${NO_COLOR}"
	fi

	curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
	echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
	curl -fsSL https://apt.fury.io/wez/gpg.key | sudo gpg --yes --dearmor -o /etc/apt/keyrings/wezterm-fury.gpg
	echo 'deb [signed-by=/etc/apt/keyrings/wezterm-fury.gpg] https://apt.fury.io/wez/ * *' | sudo tee /etc/apt/sources.list.d/wezterm.list
	wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
	sudo install -o root -g root -m 644 packages.microsoft.gpg /usr/share/keyrings/
	rm packages.microsoft.gpg
	echo "deb [arch=amd64 signed-by=/usr/share/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" | sudo tee /etc/apt/sources.list.d/vscode.list

	upgrade_cleanup

	for PKG in ${DEB_PKGS[@]}; do
		if ! dpkg -l | grep -q $PKG; then
		  sudo apt install "$PKG" -y
		  echo -e "${GREEN}[SUCESS]${NO_COLOR}"
		else
		  echo -e "${ORANGE}[INSTALED] - $PKG${NO_COLOR}"
		fi
	done

	sudo curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
	sudo chmod +x /usr/local/bin/docker-compose
	sudo usermod -aG docker $USER

	sleep 1
	echo
	echo
}

export install_deb_apps
export upgrade_cleanup
export remove_unused_apps


#!/bin/bash

# Cores para feedback no terminal
RED='\e[1;91m'
GREEN='\e[1;92m'
BLUE='\e[1;94m'
ORANGE='\e[1;93m'
NO_COLOR='\e[0m'

# Função para remover apps desnecessários
remove_unused_apps() {
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

  for APP in "${APPS[@]}"; do
    if dpkg -l | grep -q "$APP"; then
      sudo apt remove "$APP" -y
      echo -e "${GREEN}[SUCESS] - Uninstalled $APP${NO_COLOR}"
    else
      echo -e "${ORANGE}[NOT INSTALLED] - $APP${NO_COLOR}"
    fi
  done

  sleep 1
  echo -e "\n"
}

# Função para atualizar e limpar o sistema
upgrade_cleanup() {
  echo -e "${BLUE}[INFO] - Performing upgrade and cleanup...${NO_COLOR}"
  sleep 1

  sudo rm -rf /var/lib/dpkg/lock /var/lib/dpkg/lock-frontend /var/cache/apt/archives/lock
  sudo apt autoclean
  sudo apt clean
  sudo apt update -m
  sudo dpkg --configure -a
  sudo apt install -f
  sudo apt full-upgrade -y
  sudo apt autoremove -y

  sleep 1
  echo -e "\n"
}

# Função para instalar pacotes .deb e utilitários
install_deb_apps() {
  DEB_PKGS=(
    'apt-transport-https'
    'software-properties-common'
    'bashtop'
    'bat'
    'ca-certificates'
    'cpp'
    'curl'
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
  )

  # Instalar VSCode
  echo -e "${GREEN}[INFO] - Installing Visual Studio Code...${NO_COLOR}"
  wget -O vscode.deb "https://code.visualstudio.com/sha/download?build=stable&os=linux-deb-x64"
  sudo dpkg -i vscode.deb && rm vscode.deb

  # Instalar Ghostty
  echo -e "${GREEN}[INFO] - Installing Ghostty...${NO_COLOR}"
  wget https://github.com/mkasberg/ghostty-ubuntu/releases/download/1.1.3-0-ppa2/ghostty_1.1.3-0.ppa2_amd64_22.04.deb
  sudo dpkg -i ghostty_1.1.3-0.ppa2_amd64_22.04.deb && rm ghostty_1.1.3-0.ppa2_amd64_22.04.deb

  # Adicionar repositórios
  curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
  echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

  curl -fsSL https://apt.fury.io/wez/gpg.key | sudo gpg --yes --dearmor -o /etc/apt/keyrings/wezterm-fury.gpg
  echo 'deb [signed-by=/etc/apt/keyrings/wezterm-fury.gpg] https://apt.fury.io/wez/ * *' | sudo tee /etc/apt/sources.list.d/wezterm.list

  wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
  sudo install -o root -g root -m 644 packages.microsoft.gpg /usr/share/keyrings/
  rm packages.microsoft.gpg
  echo "deb [arch=amd64 signed-by=/usr/share/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" | sudo tee /etc/apt/sources.list.d/vscode.list

  # Atualizar o sistema antes da instalação
  upgrade_cleanup

  # Instalar pacotes
  for PKG in "${DEB_PKGS[@]}"; do
    if ! dpkg -l | grep -q "$PKG"; then
      echo -e "${BLUE}[INSTALLING] - $PKG${NO_COLOR}"
      sudo apt install "$PKG" -y
      echo -e "${GREEN}[SUCCESS]${NO_COLOR}"
    else
      echo -e "${ORANGE}[INSTALLED] - $PKG${NO_COLOR}"
    fi
  done

  # Instalar Docker Compose
  sudo curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
  sudo chmod +x /usr/local/bin/docker-compose
  sudo usermod -aG docker "$USER"

  sleep 1
  echo -e "\n"
}

# Exporta funções (caso seja usado como script de sourcing)
export install_deb_apps
export upgrade_cleanup
export remove_unused_apps

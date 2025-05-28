#!/bin/bash

# Cores para logs
RED='\e[1;91m'
GREEN='\e[1;92m'
BLUE='\e[1;94m'
ORANGE='\e[1;93m'
NO_COLOR='\e[0m'

install_flatpak_apps() {
  # Lista de Flatpaks organizados por categoria

  # Desenvolvimento
  FLATPAK_APPS=(
    'com.jetbrains.WebStorm'
    'com.jetbrains.IntelliJ-IDEA-Community'
    'dev.zed.Zed'
    'com.usebruno.Bruno'
    're.sonny.Commit'
    'io.beekeeperstudio.Studio'
  )

  # Comunicação
  FLATPAK_APPS+=(
    'com.discordapp.Discord'
    'com.github.IsmaelMartinez.teams_for_linux'
    'com.mattermost.Desktop'
    'org.gnome.Polari'
    'org.mozilla.Thunderbird'
  )

  # Utilitários
  FLATPAK_APPS+=(
    'com.gigitux.youp'
    'com.mattjakeman.ExtensionManager'
    'io.github.realmazharhussain.GdmSettings'
    'com.bitwarden.desktop'
  )

  # Mídia e produtividade
  FLATPAK_APPS+=(
    'com.spotify.Client'
    'md.obsidian.Obsidian'
  )

  # Navegadores e temas
  FLATPAK_APPS+=(
    'org.chromium.Chromium'
    'org.gtk.Gtk3theme.Pop-dark'
  )

  # Verifica e instala Flatpak e adiciona repositório Flathub
  if ! flatpak remote-list | grep -q "flathub"; then
    echo -e "${GREEN}[INFO] - Instalando Flatpak e adicionando repositório Flathub...${NO_COLOR}"
    sudo apt install flatpak -y &> /dev/null
    flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
  else
    echo -e "${ORANGE}[INFO] - Repositório Flathub já está adicionado.${NO_COLOR}"
  fi

  echo

  # Instalação dos apps Flatpak
  for PKG in "${FLATPAK_APPS[@]}"; do
    if ! flatpak info "$PKG" &> /dev/null; then
      echo -e "${GREEN}[INFO] - Instalando $PKG...${NO_COLOR}"
      flatpak install -y --noninteractive flathub "$PKG"
    else
      echo -e "${ORANGE}[INFO] - $PKG já está instalado.${NO_COLOR}"
    fi
  done

  echo
}

# Exporta a função para uso externo se necessário
export install_flatpak_apps

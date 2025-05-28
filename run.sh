#!/bin/bash

# Cores para mensagens
RED='\e[1;91m'
GREEN='\e[1;92m'
BLUE='\e[1;94m'
ORANGE='\e[1;93m'
NO_COLOR='\e[0m'

# Função para confirmação
confirm_step() {
  local message="$1"
  echo -e "${ORANGE}${message}${NO_COLOR}"
  while true; do
    read -p "Continue? (Y/N): " confirm
    case "${confirm,,}" in
      y|yes) return 0 ;;
      n|no) echo -e "${BLUE}Skipped.${NO_COLOR}"; return 1 ;;
      *) echo -e "${RED}Please enter Y or N.${NO_COLOR}" ;;
    esac
  done
}

# Importa scripts de funções
source ./scripts/aptitude.sh
source ./scripts/flatpak.sh
source ./scripts/gnomeExtensions.sh
source ./scripts/shell.sh
source ./scripts/asdf.sh
source ./customization/customize.sh

# Etapas com confirmação
if confirm_step "This step will update the system and clean caches"; then
  upgrade_cleanup
fi

if confirm_step "Next step will remove unused apps"; then
  remove_unused_apps
fi

if confirm_step "Next step will install APT packages"; then
  install_deb_apps
fi

if confirm_step "Next step will install Flatpak and apps"; then
  install_flatpak_apps
fi

if confirm_step "Next step will install GNOME extensions"; then
  install_gnome_extensions
fi

if confirm_step "Next step will configure the shell (zsh)"; then
  configure_shell
fi

# Etapa opcional do ASDF (comentada)
# if confirm_step "Next step will configure ASDF version manager"; then
#   configure_asdf
# fi

if confirm_step "Next step will configure fonts, icons, themes, cursor, and wallpapers"; then
  apply_custom
  dconf load / < ./pop.dconf
fi

echo -e "${GREEN}All steps completed successfully!${NO_COLOR}"

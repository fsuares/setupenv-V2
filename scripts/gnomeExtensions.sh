#!/bin/bash

install_gnome_extensions(){
	array=( https://extensions.gnome.org/extension/517/caffeine/
			https://extensions.gnome.org/extension/5004/dash-to-dock-for-cosmic/
			https://extensions.gnome.org/extension/1162/emoji-selector/
			https://extensions.gnome.org/extension/4422/gnome-clipboard/
			https://extensions.gnome.org/extension/4410/gnome-trash/
			https://extensions.gnome.org/extension/4451/logo-menu/
			https://extensions.gnome.org/extension/4470/media-controls/
			https://extensions.gnome.org/extension/8/places-status-indicator/
			https://extensions.gnome.org/extension/4491/privacy-settings-menu/
			https://extensions.gnome.org/extension/905/refresh-wifi-connections/
			https://extensions.gnome.org/extension/5237/rounded-window-corners/
			https://extensions.gnome.org/extension/906/sound-output-device-chooser/
			https://extensions.gnome.org/extension/19/user-themes/
	)

		for i in "${array[@]}"
		do
			EXTENSION_ID=$(curl -s $i | grep -oP 'data-uuid="\K[^"]+')
			VERSION_TAG=$(curl -Lfs "https://extensions.gnome.org/extension-query/?search=$EXTENSION_ID" | jq '.extensions[0] | .shell_version_map | map(.pk) | max')
			wget -O ${EXTENSION_ID}.zip "https://extensions.gnome.org/download-extension/${EXTENSION_ID}.shell-extension.zip?version_tag=$VERSION_TAG"
			gnome-extensions install --force ${EXTENSION_ID}.zip
			sleep 1
				echo
				echo
			if ! gnome-extensions list | grep --quiet ${EXTENSION_ID}; then
				busctl --user call org.gnome.Shell.Extensions /org/gnome/Shell/Extensions org.gnome.Shell.Extensions InstallRemoteExtension s ${EXTENSION_ID}
				sleep 1
						echo
						echo
			fi
			gnome-extensions enable ${EXTENSION_ID}
			rm ${EXTENSION_ID}.zip
			sleep 1
				echo
				echo
		done
}

export install_gnome_extensions

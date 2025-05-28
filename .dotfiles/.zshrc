
eval "$(starship init zsh)"
source /home/ducck/antigen.zsh

# Load the oh-my-zsh's library.
antigen use oh-my-zsh

# Bundles from the default repo (robbyrussell's oh-my-zsh).
antigen bundle git
antigen bundle heroku
antigen bundle pip
antigen bundle lein
antigen bundle command-not-found

# Syntax highlighting bundle.
antigen bundle zsh-users/zsh-syntax-highlighting

# Tell Antigen that you're done.
antigen apply

# Alias
# Navigation
alias .="cd .."
alias ..="cd ..."
alias ...="cd ...."
alias exa="exa --color=always"
alias l='exa -lh --icons'
alias ll='exa -lha --icons'
alias c='clear && nerdfetch'
alias clip='xclip -selection clipboard'
alias rm='trash'

# Terminal shortcuts
alias bat='batcat'
alias vim='nvim'
alias top='bashtop'

# APT
alias install='sudo apt install'
alias remove='sudo apt remove --purge -y'
alias update='sudo apt update'
alias upgrade='sudo apt upgrade -y'
alias aremove='sudo apt autoremove -y'
alias aclean='sudo apt autoclean'
alias list-up='apt list --upgradable'

# FLATPAK
alias fsearch='flatpak search'
alias finstall='flatpak install'
alias fremove='flatpak remove'

alias yt-aud='yt-dlp -x --audio-format mp3 --embed-metadata --embed-thumbnail --add-metadata -P $HOME/Music'
alias yt-vide='yt-dlp --add-metadata --embed-metadata --embed-thumbnail -P $HOME/Videos/'

# Paths
export PATH="${ASDF_DATA_DIR:-$HOME/.asdf}/shims:$PATH"


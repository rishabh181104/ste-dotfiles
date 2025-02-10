#!/bin/bash

# Run fastfetch if available
if [ -f /usr/bin/fastfetch ]; then
	fastfetch
fi

# Load aliases
[ -s ~/.alias ] && source ~/.alias || true

# Load syntax highlighting
[ -f "$HOME/.bash-syntax-highlighting/fast-syntax-highlighting.plugin.bash" ] && source "$HOME/.bash-syntax-highlighting/fast-syntax-highlighting.plugin.bash"

# Load Starship prompt
if command -v starship &>/dev/null; then
	eval "$(starship init bash)"
fi

# Load fzf key bindings and completion
if [ -d "$HOME/.fzf" ]; then
	source "$HOME/.fzf.bash"
fi

# Load preexec for improved performance
if [ -f "$HOME/.bash-preexec/bash-preexec.sh" ]; then
	source "$HOME/.bash-preexec/bash-preexec.sh"
fi

# Optimized history settings
export HISTSIZE=10000
export HISTFILESIZE=20000
export HISTTIMEFORMAT="%F %T "
export HISTCONTROL=ignoredups:erasedups
shopt -s histappend
PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"

# XDG directory variables
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_STATE_HOME="$HOME/.local/state"
export XDG_CACHE_HOME="$HOME/.cache"

# Environment variables
export WORKSPACE="$HOME/Projects"
export NODE_ENV=development
export PYTHONPATH="$HOME/.local/lib/python3.10/site-packages:$PYTHONPATH"

# Functions
extract() {
	for archive in "$@"; do
		[ -f "$archive" ] || { echo "'$archive' is not a valid file!"; continue; }
		case $archive in
			*.tar.bz2|*.tbz2) tar xjf "$archive" ;;
			*.tar.gz|*.tgz) tar xzf "$archive" ;;
			*.bz2) bunzip2 "$archive" ;;
			*.rar) rar x "$archive" ;;
			*.gz) gunzip "$archive" ;;
			*.tar) tar xvf "$archive" ;;
			*.zip) unzip "$archive" ;;
			*.7z) 7z x "$archive" ;;
			*) echo "don't know how to extract '$archive'..." ;;
		esac
	done
}

ftext() { grep -iIHrn --color=always "$1" . | less -R; }

# Auto list directory contents on cd
chpwd() { ls; }

# Git aliases
alias gcom='git add . && git commit -m "$1"'
alias lazyg='git add . && git commit -m "$1" && git push'

# Optimized PATH
export PATH="$HOME/.local/bin:$HOME/.cargo/bin:$HOME/.npm-global/bin:/var/lib/flatpak/exports/bin:$HOME/.local/share/flatpak/exports/bin:$PATH"

# Default editor
export EDITOR=nvim
export VISUAL=nvim

# System update aliases
alias u='sudo zypper ref && sudo zypper dup -y'
alias zpr='zypper'
alias reboot='sudo reboot now'
alias run='python3'
alias clr='clear'
alias recom='sudo zypper install-new-recommends'

# Colors for ls and grep
export CLICOLOR=1
export LS_COLORS='no=00:fi=00:di=00;34:ln=01;36:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:ex=01;32:*.tar=01;31:*.tgz=01;31:*.zip=01;31:*.gz=01;31:*.bz2=01;31:*.jpg=01;35:*.png=01;35:*.mp3=01;35:*.wav=01;35:*.xml=00;31:'

# Use ripgrep if available
if command -v rg &>/dev/null; then
	alias grep='rg'
else
	alias grep='/usr/bin/grep --color=auto'
fi

# Color for manpages
export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;31m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;44;33m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;32m'

# Directory navigation aliases
alias home='cd ~'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias bd='cd "$OLDPWD"'

# ls aliases
alias la='ls -Alh'
alias ls='ls -aFh --color=always'
alias ll='ls -Fls'

# chmod aliases
alias mx='chmod a+x'
alias 644='chmod -R 644'
alias 755='chmod -R 755'

# Search aliases
alias h="history | grep"
alias p="ps aux | grep"
alias f="find . | grep"

# Docker cleanup
alias docker-clean='docker container prune -f; docker image prune -f; docker network prune -f; docker volume prune -f'


if [ -f /usr/bin/fastfetch ]; then
	fastfetch
fi
# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
	source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

ZINIT_HOME="XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

if [ ! -d "$ZINIT_HOME" ]; then
	mkdir -p "$(dirname $ZINIT_HOME)"
	git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

source "${ZINIT_HOME}/zinit.zsh"

zinit ice depth=1; zinit light romkatv/powerlevel10k

# Add these new lines for syntax highlighting
zinit ice wait lucid
zinit light zdharma-continuum/fast-syntax-highlighting

# Optional but recommended plugins for better shell experience
zinit ice wait lucid
zinit light zsh-users/zsh-autosuggestions

zinit ice wait lucid
zinit light zsh-users/zsh-completions

# History settings
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
HISTTIMEFORMAT="%F %T"

# Don't put duplicate lines in the history
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_EXPIRE_DUPS_FIRST
setopt SHARE_HISTORY
setopt EXTENDED_HISTORY

# set up XDG folders
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_STATE_HOME="$HOME/.local/state"
export XDG_CACHE_HOME="$HOME/.cache"

export LINUXTOOLBOXDIR="$HOME/linuxtoolbox"

# Custom Environment Variables
export WORKSPACE=~/Projects
export PATH="$HOME/.local/bin:$PATH"
export NODE_ENV=development
export PYTHONPATH="$HOME/.local/lib/python3.10/site-packages:$PYTHONPATH"


# Set the default editor
export EDITOR=nvim
export VISUAL=nvim
alias spico='sudo pico'
alias snano='sudo nano'
alias n='nvim'
alias nvi='nvim'
alias nv='nvim'
alias u='sudo zypper ref && sudo zypper dup'
alias zpr='zypper'
alias reboot='sudo reboot now'
alias run="python3"
alias clr="clear"

# Colors for ls and grep
export CLICOLOR=1
export LS_COLORS='no=00:fi=00:di=00;34:ln=01;36:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.gz=01;31:*.bz2=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.jpg=01;35:*.jpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.avi=01;35:*.fli=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.ogg=01;35:*.mp3=01;35:*.wav=01;35:*.xml=00;31:'

# Check if ripgrep is installed
if command -v rg &> /dev/null; then
	alias grep='rg'
else
	alias grep="/usr/bin/grep --color=auto"
fi

# Color for manpages
export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;31m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;44;33m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;32m'

# All aliases from .bashrc remain the same
alias web='cd /var/www/html'
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'
alias ezrc='edit ~/.zshrc'
alias da='date "+%Y-%m-%d %A %T %Z"'

# Standard command aliases
alias cp='cp -i'
alias mv='mv -i'
alias rm='trash -v'
alias mkdir='mkdir -p'
alias ps='ps auxf'
alias ping='ping -c 10'
alias less='less -R'
alias cls='clear'
alias vi='nvim'
alias svi='sudo vi'
alias vis='nvim "+set si"'

# Directory navigation
alias home='cd ~'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias bd='cd "$OLDPWD"'

# ls aliases
alias la='ls -Alh'
alias ls='ls -aFh --color=always'
alias lx='ls -lXBh'
alias lk='ls -lSrh'
alias lc='ls -ltcrh'
alias lu='ls -lturh'
alias lr='ls -lRh'
alias lt='ls -ltrh'
alias lm='ls -alh |more'
alias lw='ls -xAh'
alias ll='ls -Fls'
alias labc='ls -lap'
alias lf="ls -l | egrep -v '^d'"
alias ldir="ls -l | egrep '^d'"

# chmod aliases
alias mx='chmod a+x'
alias 000='chmod -R 000'
alias 644='chmod -R 644'
alias 666='chmod -R 666'
alias 755='chmod -R 755'
alias 777='chmod -R 777'

# Search aliases
alias h="history | grep"
alias p="ps aux | grep"
alias f="find . | grep"

# Docker cleanup
alias docker-clean='docker container prune -f ; docker image prune -f ; docker network prune -f ; docker volume prune -f'

# Convert bash functions to zsh functions
# Extract function
extract() {
	for archive in "$@"; do
		if [ -f "$archive" ]; then
			case $archive in
				*.tar.bz2) tar xvjf $archive ;;
				*.tar.gz) tar xvzf $archive ;;
				*.bz2) bunzip2 $archive ;;
				*.rar) rar x $archive ;;
				*.gz) gunzip $archive ;;
				*.tar) tar xvf $archive ;;
				*.tbz2) tar xvjf $archive ;;
				*.tgz) tar xvzf $archive ;;
				*.zip) unzip $archive ;;
				*.Z) uncompress $archive ;;
				*.7z) 7z x $archive ;;
				*) echo "don't know how to extract '$archive'..." ;;
			esac
		else
			echo "'$archive' is not a valid file!"
		fi
	done
}

# Other functions remain largely the same
ftext() {
	grep -iIHrn --color=always "$1" . | less -r
}

# Directory navigation after cd
chpwd() {
	ls
}

# Git functions
gcom() {
	git add .
	git commit -m "$1"
}

lazyg() {
	git add .
	git commit -m "$1"
	git push
}

# Path
export PATH=$PATH:"$HOME/.local/bin:$HOME/.cargo/bin:/var/lib/flatpak/exports/bin:/.local/share/flatpak/exports/bin"

# ZSH-specific settings
autoload -U compinit && compinit
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
setopt AUTO_CD
setopt EXTENDED_GLOB
setopt PROMPT_SUBST
setopt NO_CASE_GLOB
setopt NUMERIC_GLOB_SORT
setopt INTERACTIVE_COMMENTS

# Key bindings (similar to bash but for zsh)
bindkey '^R' history-incremental-search-backward
bindkey '^F' forward-word
bindkey '^B' backward-word
bindkey '^A' beginning-of-line
bindkey '^E' end-of-line
bindkey '^[[3~' delete-char
bindkey '^H' backward-delete-char
bindkey '^[[A' up-line-or-history
bindkey '^[[B' down-line-or-history

# Add zsh-specific completion settings
zstyle ':completion:*' menu select
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}


export PATH=~/.npm-global/bin:$PATH


# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

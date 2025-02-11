if status is-interactive
	fastfetch
end

# Set environment variables
set -gx EDITOR nvim
set -gx TERMINAL alacritty
set -gx BROWSER firefox
set -gx FILE ~/.config/fish/config.fish
set -gx STARSHIP_CONFIG ~/.config/starship.toml
set -gx VISUAL nvim
set -gx SSH_AUTH_SOCK $XDG_RUNTIME_DIR/ssh-agent.socket
set -gx LANG en_US.UTF-8
set -gx LC_ALL en_US.UTF-8
set -gx PATH $HOME/.local/bin $PATH
set -gx PATH /usr/local/bin $PATH
set -gx PATH /usr/bin $PATH

# Aliases
alias ls='ls --color=auto'
alias ll='ls -lah'
alias la='ls -a'
alias l='ls -CF'
alias vim='nvim'
alias cls='clear'
alias reboot='sudo reboot'
alias grep='grep --color=auto'
alias upgrade='sudo zypper ref && sudo zypper dup -y'
alias remove='sudo zypper remove'
alias search='zypper se'
alias install='sudo zypper in'
alias c='clear'
alias n='nvim'
alias nv='nvim'
alias nvi='nvim'
alias v='nvim'
alias duf='duf -hide special'
alias mkdir='mkdir -p'

# Functions
function fish_greeting
	echo "THIS IS FISH, BRUV!:)"
end

function mkcd
	mkdir -p $argv[1]; and cd $argv[1]
end

function reload
	exec fish
end

function fish_prompt
	starship prompt
end

# Source other configs if necessary
if test -f ~/.config/fish/local.fish
	source ~/.config/fish/local.fish
end

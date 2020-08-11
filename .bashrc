# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

PATH="$HOME/bin:$HOME/.cargo/bin:$HOME/.local/bin:$PATH"
export PATH

# User specific aliases and functions
HISTCONTROL="ignoreboth"
HISTIGNORE="ls:[bf]g:exit:pwd:clear"

# Setup NeoVim alias for Vim
if [ -e "$(type -p nvim.appimage)" ]; then
  alias vim=nvim.appimage
fi

# Setup Starship prompt
if [ -e "$(type -p starship)" ]; then
  eval "$(starship init bash)"
fi

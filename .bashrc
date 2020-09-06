# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

PATH="$HOME/bin:$HOME/.cargo/bin:$HOME/.local/bin:$PATH"
export PATH

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions
HISTCONTROL="ignoreboth"
HISTIGNORE="ls:[bf]g:exit:pwd:clear"

# _maybe_alias() <alias> <target> [...]
# Evaluate target commands by searching path for executable file.
# If found found create alias mapping to matching target.
#
# Args:
# alias = Name of alias
# target = Target command for alias
_maybe_alias() {
  local _name=$1
  local _target
  shift
  for _target in $*; do
    if [ -e "$(type -p $_target)" ]; then
      alias $_name="$(type -p $_target)"
      break
    fi
  done
}

# Setup NeoVim alias for Vim
_maybe_alias vim nvim.appimage nvim
if [ -n $NVIM_LISTEN_ADDRESS ]; then
  alias vim="nvhoist ${BASH_ALIASES[vim]}"
fi

# Setup Starship prompt
if [ -e "$(type -p starship)" ]; then
  eval "$(starship init bash)"
fi

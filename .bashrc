# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# Fix ssh auth sock
alias agentfix='. ~/dotfiles/inc/agentfix.sh'

# Source color macros
. ~/dotfiles/inc/colors.sh
. ~/dotfiles/inc/git-prompt.sh

fixPrompt() {
  printf "\033k%s@%s:%s\033\\" "${USER}" "${HOSTNAME%%.*}" "${PWD/#$HOME/~}"
  USERCOLOR="${HYAC["YELLOW"]}"
}

# Set up prompt
PROMPT_COMMAND=""
PROMPT_DIRTRIM=4
PS1='${HYAC["BLUE"]}\342\224\214\342\224\200[${HYAC["RED"]}${USERCOLOR}\u@\h${HYAC["BLUE"]}]${HYAC["RESET"]} \w\n$(__git_ps1 "(%s)")\$ '
export PROMPT_DIRTRIM PS1

# Make sure all host-keys are hashed
ssh-keygen -H 2>/dev/null

# Docker aliases / functions
alias docker-id="docker inspect --format '{{ .Id }}'"
alias docker-ip="docker inspect --format '{{ .NetworkSettings.IPAddress }}'"
alias docker-pid="docker inspect --format '{{ .State.Pid }}'"
docker-shell () 
{ 
   cd /var/lib/docker/execdriver/native/$(docker-id "$1")
   nsinit exec bash
   cd -
}

# Fix history settings
HISTCONTROL="ignoreboth"

# GIT aliases
alias gs="git status"

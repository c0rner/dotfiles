# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# Fix ssh auth sock
alias agentfix='. ~/dotfiles/inc/agentfix.sh'
agentfix

# Source color macros
. ~/dotfiles/inc/colors.sh

fixPrompt() {
  printf "\033k%s@%s:%s\033\\" "${USER}" "${HOSTNAME%%.*}" "${PWD/#$HOME/~}"
  USERCOLOR="${HYAC["YELLOW"]}"
}

# Set up prompt
PROMPT_COMMAND='fixPrompt'
PROMPT_DIRTRIM=4
PS1="${HYAC["BLUE"]}\342\224\214\342\224\200[${HYAC["RED"]}\${USERCOLOR}\u@\h${HYAC["BLUE"]}]${HYAC["RESET"]} \w\n\\$ "
export PROMPT_DIRTRIM PS1

# Make sure all host-keys are hashed
ssh-keygen -H 2>/dev/null

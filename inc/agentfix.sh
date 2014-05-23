# Agentfix - Keep SSH_AUTH_SOCK working in multi-sessions; https://github.com/c0rner/dotfiles

#  Multiple ssh sessions combined  with a terminal multiplexer will completely
#  mess up SSH_AUTH_SOCK. This script tries to set things straight..

# Do not run outside TMUX or SCREEN
[ -z "${TMUX}" -a -z "${STY}" ] && return

# Unset SSH_AUTH_SOCK if set and invalid
if [ -n "${SSH_AUTH_SOCK}" ]; then
   if [ ! -S "${SSH_AUTH_SOCK}" ]; then
      unset SSH_AUTH_SOCK
   else
      ssh-add 2>/dev/null
      if [ $? -eq 2 ]; then
         rm -f "${SSH_AUTH_SOCK}"
         unset SSH_AUTH_SOCK
      fi
   fi
fi
export SSH_AUTH_SOCK

# SSH_AUTH_SOCK not set, try finding a socket
if [ -z "${SSH_AUTH_SOCK}" ]; then
   if [ -S "${HOME}/.ssh/agent" ]; then
      SSH_AUTH_SOCK="${HOME}/.ssh/agent"
   else
      # Search for sockets owned by us in /tmp
      for dir in $(ls -d "/tmp/ssh-"*); do
         if [ ${UID} -eq $(stat "${dir}" -c "%u") ]; then
            SSH_AUTH_SOCK=$(readlink -f "${dir}/agent"*)
            if [ -S "${SSH_AUTH_SOCK}" ]; then
               ssh-add 2>/dev/null
               [ $? -lt 2 ] && break
            fi
            unset SSH_AUTH_SOCK
         fi
      done
   fi
fi

# Create static link to a working socket
if [ ! -S "${HOME}/.ssh/agent" ]; then
   [ -L "${HOME}/.ssh/agent" ] && rm "${HOME}/.ssh/agent"
   if [ -n "${SSH_AUTH_SOCK}" ]; then
      ln -s "${SSH_AUTH_SOCK}" "${HOME}/.ssh/agent"
      SSH_AUTH_SOCK="${HOME}/.ssh/agent"
      export SSH_AUTH_SOCK
   fi
else
   SSH_AUTH_SOCK="${HOME}/.ssh/agent"
   export SSH_AUTH_SOCK
fi

[ -n $BASH_VERSINFO -a $BASH_VERSINFO -eq 4 ] || { echo "error: need BASH v4" >&2; return; }
[ $TERM == "dumb" ] && return

# TermInfo feature detection (Borrowed from LiquidPrompt)
if tput setaf >/dev/null 2>&1 ; then
   ti_setaf () { tput setaf "$1" ; }
elif tput AF >/dev/null 2>&1 ; then
   # *BSD
   ti_setaf () { tput AF "$1" ; }
elif tput AF 1 >/dev/null 2>&1 ; then
   # OpenBSD
   ti_setaf () { tput AF "$1" ; }
else
   echo "error: terminal '$TERM' not supported" >&2
   ti_setaf () { : ; }
fi

declare -A HYAC
HYAC["BOLD"]="$( { tput bold || tput md ; } 2>/dev/null )"
HYAC["BLACK"]="$(ti_setaf 0)"
HYAC["RED"]="$(ti_setaf 1)"
HYAC["GREEN"]="$(ti_setaf 2)"
HYAC["YELLOW"]="$(ti_setaf 3)"
HYAC["BLUE"]="$(ti_setaf 4)"
HYAC["MAGENTA"]="$(ti_setaf 5)"
HYAC["CYAN"]="$(ti_setaf 6)"
HYAC["WHITE"]="$(ti_setaf 7)"
HYAC["RESET"]="$( { tput sgr0 || tput me ; } 2>/dev/null )"
unset ti_setaf

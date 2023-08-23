MACHINE_="%{$fg_bold[blue]%}%m%{$fg[white]%} ):%{$reset_color%}"
CUR_USER_="%{$fg_bold[green]%}%n%{$reset_color%}"

# Grab the current filepath, use shortcuts: ~/Desktop
PATH_="%{$fg[cyan]%}%~%{$reset_color%}"
CMD_="%{$fg[cyan]%}%~%{$reset_color%}"
# Grab the current time (%T) wrapped in {}
CUR_TIME_="%{$fg[white]%}{%{$fg[yellow]%}%T%{$fg[white]%}}%{$reset_color%}"
# Put it all together!
PROMPT="$CUR_TIME_$CUR_USER_$CMD_
   "

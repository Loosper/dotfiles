# Path to your oh-my-zsh installation.
export ZSH=/home/loosper/.oh-my-zsh

# ZSH_THEME='robbyrussell'
ZSH_THEME="junkfood"
# ZSH_THEME="spaceship"
HIST_IGNORE_DUPS="true"
CASE_SENSITIVE="false"
HYPHEN_INSENSITIVE="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

plugins=(
  git
  python
  command-not-found
  alias-tips
  zsh-autosuggestions
)

source $ZSH/oh-my-zsh.sh
# fish like syntax highlighs
# needs package zsh-syntax-highlighting
source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets line pattern)
ZSH_HIGHLIGHT_STYLES[line]='bold'
ZSH_HIGHLIGHT_PATTERNS=('rm -rf *' 'fg=white,bold,bg=blue')
ZSH_HIGHLIGHT_STYLES[default]='fg=cyan,bold' #base1
ZSH_HIGHLIGHT_STYLES[alias]='fg=white'
ZSH_HIGHLIGHT_STYLES[builtin]='fg=yellow'
ZSH_HIGHLIGHT_STYLES[function]='fg=white'
ZSH_HIGHLIGHT_STYLES[command]='fg=white'
ZSH_HIGHLIGHT_STYLES[precommand]='fg=white'
ZSH_HIGHLIGHT_STYLES[commandseparator]='fg=green,bold' #base01
ZSH_HIGHLIGHT_STYLES[path]='fg=cyan'
ZSH_HIGHLIGHT_STYLES[single-hyphen-option]='fg=blue,bold' #base0
ZSH_HIGHLIGHT_STYLES[double-hyphen-option]='fg=blue,bold' #base0
ZSH_HIGHLIGHT_STYLES[back-quoted-argument]='fg=red,bold' #orange

# # tmux dynamic title
# autoload -Uz add-zsh-hook
# 
# function xterm_title_precmd () {
# 	print -Pn '\e]2;%n@%m %~\a'
# 	[[ "$TERM" == 'screen'* ]] && print -Pn '\e_\005{g}%n\005{-}@\005{m}%m\005{-} \005{B}%~\005{-}\e\\'
# }
# 
# function xterm_title_preexec () {
# 	print -Pn '\e]2;%n@%m %~ %# ' && print -n "${(q)1}\a"
# 	[[ "$TERM" == 'screen'* ]] && { print -Pn '\e_\005{g}%n\005{-}@\005{m}%m\005{-} \005{B}%~\005{-} %# ' && print -n "${(q)1}\e\\"; }
# }
# 
# if [[ "$TERM" == (screen*|xterm*|rxvt*) ]]; then
# 	add-zsh-hook -Uz precmd xterm_title_precmd
# 	add-zsh-hook -Uz preexec xterm_title_preexec
# fi


export VISUAL=vim
export EDITOR="$VISUAL"
export PAGER=less

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
# export PATH="$PATH:$HOME/.rvm/bin"
# export HISTCONTROL=ignoreboth:erasedups

alias gdb='gdb -q -ex="set disassemble-next-line on"'
alias copy="xclip -selection clipboard -i"
alias paste="xclip -selection clipboard -o"
alias prettyjson="python -mjson.tool"
alias packettracer="/opt/pt/bin/PacketTracer7"
alias vim=vim.gtk3

alias diff='diff --color=auto'
alias grep="grep --color=auto --exclude-dir={node_modules,.env,.git,__pycache__}"
alias dmesg="dmesg --color=always"
alias ls='ls --color=auto'

export GREP_COLOR="1;32"

export LESS=-R
export LESS_TERMCAP_mb=$'\E[1;31m'     # begin blink
export LESS_TERMCAP_md=$'\E[1;36m'     # begin bold
export LESS_TERMCAP_me=$'\E[0m'        # reset bold/blink
export LESS_TERMCAP_so=$'\E[01;44;33m' # begin reverse video
export LESS_TERMCAP_se=$'\E[0m'        # reset reverse video
export LESS_TERMCAP_us=$'\E[1;32m'     # begin underline
export LESS_TERMCAP_ue=$'\E[0m'        # reset underline

# export LESS_TERMCAP_mb=$(tput bold; tput setaf 2) # green
# export LESS_TERMCAP_md=$(tput bold; tput setaf 6) # cyan
# export LESS_TERMCAP_me=$(tput sgr0)
# export LESS_TERMCAP_so=$(tput bold; tput setaf 3; tput setab 4) # yellow on blue
# export LESS_TERMCAP_se=$(tput rmso; tput sgr0)
# export LESS_TERMCAP_us=$(tput smul; tput bold; tput setaf 7) # white
# export LESS_TERMCAP_ue=$(tput rmul; tput sgr0)
# export LESS_TERMCAP_mr=$(tput rev)
# export LESS_TERMCAP_mh=$(tput dim)
# export LESS_TERMCAP_ZN=$(tput ssubm)
# export LESS_TERMCAP_ZV=$(tput rsubm)
# export LESS_TERMCAP_ZO=$(tput ssupm)
# export LESS_TERMCAP_ZW=$(tput rsupm)
# export GROFF_NO_SGR=1         # For Konsole and Gnome-terminal
# Get color support for 'less'
export LESS="--RAW-CONTROL-CHARS"

export LD_LIBRARY_PATH=/usr/local/lib
export PATH=$PATH:/usr/local/cross-compiler/bin/
export PATH=$PATH:~/.local/bin
export PYTHONSTARTUP=~/.pythonrc

# alieas shows all aliases
# ^C+a will expand an alias
# man zshall - all builtins for zsh
# dirs shows last visited directories
# cd <number> goes to that diorectory
# https://mayccoll.github.io/Gogh/#0 - cool colours for terminal emulators
# cute prompt https://github.com/denysdovhan/spaceship-prompt/

# cute commands: sl, gti


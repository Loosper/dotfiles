ZSH_THEME="junkfood"

HIST_IGNORE_DUPS="true"
HYPHEN_INSENSITIVE="true"

# ENABLE_CORRECTION="true"

# COMPLETION_WAITING_DOTS="true"

plugins=(
  git
  python
  command-not-found
)

source $ZSH/oh-my-zsh.sh

if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='mvim'
fi


alias gdb='gdb -q'
export VISUAL=vim
export EDITOR="$VISUAL"
alias copy="xclip -selection clipboard -i"
alias paste="xclip -selection clipboard -o"
export LD_LIBRARY_PATH=/usr/local/lib

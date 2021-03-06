# Path to your oh-my-zsh installation.
export ZSH=/home/loosper/.oh-my-zsh

ZSH_THEME="junkfood"
HIST_IGNORE_DUPS="true"
CASE_SENSITIVE="false"
HYPHEN_INSENSITIVE="true"
HIST_STAMPS="%d/%m/%y"
DISABLE_AUTO_UPDATE="true"

# look at themes.md for info on how to get missing ones
plugins=(
  git
  python
  systemd
  archlinux
  command-not-found
  alias-tips
  zsh-autosuggestions
  zsh-syntax-highlighting
)

# set up ssh-agent
# eval $(keychain -Q --agents ssh --noask --eval --quiet `find ~/.ssh/keys | grep "\.key$" --color=never`)

source $ZSH/oh-my-zsh.sh

# TODO: this behaves strange. The shell needs to exit to save its history.
INC_APPEND_HISTORY="true"
setopt no_share_history
unsetopt share_history

# fish like syntax highlighs for zsh-syntax-highlighting
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets line pattern)
ZSH_HIGHLIGHT_STYLES[line]='bold'
ZSH_HIGHLIGHT_PATTERNS=('rm -rf *' 'fg=white,bold,bg=blue')
ZSH_HIGHLIGHT_PATTERNS+=('sudo' 'fg=red,bold')
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
ZSH_HIGHLIGHT_STYLES[comment]='fg=gray,bold'

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

# aliases
alias gdb='gdb -q -ex="set disassemble-next-line on"'
alias copy="xclip -selection clipboard -i"
alias paste="xclip -selection clipboard -o"
alias prettyjson="python -mjson.tool"
alias packettracer="/opt/pt/bin/PacketTracer7"
#alias vim=vim.gtk3
alias vimzshrc="vim ~/.zshrc"
alias vimvimrc="vim ~/.vimrc"
alias diff='diff --color=auto'
alias grep="grep --color=auto --exclude-dir={node_modules,.env,.git,__pycache__} --exclude tags -I"
alias dmesg="dmesg --color=always"
alias ls='ls --color=auto'
alias ip='ip --color=auto'
# pacman has a colour option in /etc/pacman.conf
alias sudo='sudo -E'
alias digs='dig +short'
alias open='xdg-open'
alias cpr='cp -r'
alias qemu-system-aarch64='~/system/qemu/build/aarch64-softmmu/qemu-system-aarch64'
alias less='less -i'

# settings
export VISUAL=vim
export EDITOR="$VISUAL"
export PAGER=less

# colours for programs
export GREP_COLOR="1;32"
export LESS=-R
export LESS_TERMCAP_mb=$'\E[1;31m'     # begin blink
export LESS_TERMCAP_md=$'\E[1;36m'     # begin bold
export LESS_TERMCAP_me=$'\E[0m'        # reset bold/blink
export LESS_TERMCAP_so=$'\E[01;44;33m' # begin reverse video
export LESS_TERMCAP_se=$'\E[0m'        # reset reverse video
export LESS_TERMCAP_us=$'\E[1;32m'     # begin underline
export LESS_TERMCAP_ue=$'\E[0m'        # reset underline
# Get color support for 'less'
export LESS="--RAW-CONTROL-CHARS"

# variable exports
export LD_LIBRARY_PATH=/usr/local/lib
# TODO: make a /bin folder inside system and symlink everything there (or move ~/system to an actual system dir)
# either /opt or /usr/bin or /usr/local/bin should be the one you need
export PATH=$PATH:/usr/local/cross-compiler/bin/
export PATH=$PATH:~/.local/bin
export PATH=$PATH:~/system/cross/bin
export PATH=$PATH:~/system/cross/aarch64-none-linux-gnu/bin
export PYTHONSTARTUP=~/.pythonrc
# export PATH="$PATH:$HOME/.rvm/bin"
# export HISTCONTROL=ignoreboth:erasedups

# alias shows all aliases
# ^C+a will expand an alias
# man zshall - all builtins for zsh
# dirs shows last visited directories
# cd <number> goes to that diorectory
# https://mayccoll.github.io/Gogh/#0 - cool colours for terminal emulators
# cute prompt https://github.com/denysdovhan/spaceship-prompt/

# cute commands: sl, gti

function unmv {
    mv $2 $1
}

function swap() {
    local TMPFILE=tmp.$$
    mv "$1" $TMPFILE
    mv "$2" "$1"
    mv $TMPFILE "$2"
}

if [ -z $TMUX ]; then
    # the systemd part is an attempt to not have tmux killed on logoff (TODO: check if this is working)
    systemd-run --scope --user tmux attach
fi

# git log --pretty=ful
# git log --no-merges

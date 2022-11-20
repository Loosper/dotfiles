# Path to your oh-my-zsh installation.
export ZSH=/home/loosper/.oh-my-zsh

# TODO: https://mayccoll.github.io/Gogh/#0 - cool colours for terminal emulators
# TODO: cute prompt https://github.com/denysdovhan/spaceship-prompt/
# NOTE: I have junkfood editted with:
# PROMPT="$JUNKFOOD_CURRENT_USER_$JUNKFOOD_LOCA_
ZSH_THEME="junkfood"
CASE_SENSITIVE="false"
HYPHEN_INSENSITIVE="true"
DISABLE_AUTO_UPDATE="true"
HIST_IGNORE_DUPS="true"
HIST_STAMPS="%d/%m/%y"
# SHARE_HISTORY reads it as well. Undesirable cos I want separete shells to
# remain so for their lifetime
# TODO: I suspect zsh doesn't cache the read copy and it updates anyway. Seems
# to be why I had this off in the first place
INC_APPEND_HISTORY="true"

# look at themes.md for info on how to get missing ones
plugins=(
    python
    systemd
    archlinux
    command-not-found # need command-not-found system package
    alias-tips
    # look at README to install
    zsh-autosuggestions
    zsh-syntax-highlighting
)

# set up ssh-agent
# eval $(keychain -Q --agents ssh --noask --eval --quiet `find ~/.ssh/keys | grep "\.key$" --color=never`)

source $ZSH/oh-my-zsh.sh

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

# --- commands ---
# which <alias> will show what it maps to
# man zshall - all builtins for zsh
# dirs shows last visited directories
#   cd <number> goes to that directory
# cute commands: sl, gti
alias gdb='gdb -q -ex="set disassemble-next-line on"'
alias copy="xclip -selection clipboard -i"
alias paste="xclip -selection clipboard -o"
alias prettyjson="python -mjson.tool"
alias packettracer="/opt/pt/bin/PacketTracer7"
#alias vim=vim.gtk3
alias vimzshrc="vim ~/.zshrc"
alias vimvimrc="vim ~/.vimrc"
alias diff='diff --color=auto'
GREP_OPTS="--color=auto --exclude-dir={node_modules,.env,.git,__pycache__} --exclude tags -I -n"
alias cgrep="/bin/grep" # clean grep
alias grep="grep $GREP_OPTS"
alias igrep="grep -i $GREP_OPTS"
alias rgrep="rgrep $GREP_OPTS"
alias rigrep="rgrep -i $GREP_OPTS"
alias egrep="egrep $GREP_OPTS"
alias fgrep="fgrep $GREP_OPTS"
alias dmesg="dmesg --color=always"
alias ls='ls --color=auto'
alias ip='ip --color=auto'
# pacman has a colour option in /etc/pacman.conf
alias sudo='sudo -E'
alias digs='dig +short'
alias open='xdg-open'
alias less='less -i'
# force systemd to not kill tmux on logoff
alias tmux="systemd-run --scope --user tmux"
# this git plugin sucks, so roll my own
alias g="git"
alias gb="git branch"
alias grh="git reset"
alias grhh="git reset --hard"
alias gco="git checkout"
alias gcob="git checkout -b"
alias gsh="git show --format=medium --abbrev-commit"
alias gbl="git blame"
alias gd="git diff"
alias gds="git diff --staged"
alias gfa="git fetch --all"
alias gm="git merge"
# commit
alias gst="git status"
alias ga="git add"
alias gc="git commit -v"
alias gcmsg="git commit -v -m"
alias gcmsgs="git commit -v -m -s" # signed
alias gc!="git commit -v --amend"
# push/pull
alias gl="git pull"
alias glr="git pull --rebase"
alias gp="git push"
# rebase
alias grb="git rebase"
alias grbi="git rebase -i"
alias grbc="git rebase --continue"
alias grba="git rebase --abort"
# stash
alias gsta="git stash save"
alias gstp="git stash pop"
alias gsts="git stash show -p"
alias gstl="git stash list"
alias gstd="git stash drop"
# log
alias glg="git log"
alias glgs="git log --stat"
alias glgp="git log --stat --patch"
alias glgnm="git log --no-merges"

function unmv {
    mv $2 $1
}

function swap() {
    local TMPFILE=tmp.$$
    mv "$1" $TMPFILE
    mv "$2" "$1"
    mv $TMPFILE "$2"
}

# --- settings ---
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
export PATH=$PATH:~/.local/bin
export PYTHONSTARTUP=~/.pythonrc
# export PATH="$PATH:$HOME/.rvm/bin"

if [ -z $TMUX ]; then
    tmux attach
fi

# this dir has all system-specific toolchains and such which need to be in $PATH
# add them to the path in a system specific manner
source ~/system/.zsh_system_source

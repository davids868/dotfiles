# Download Znap, if it's not there yet.
export ZNAP_PATH="$HOME/personal/zsh-snap"

[[ -f $ZNAP_PATH/znap.zsh ]] ||
    git clone --depth 1 -- \
        https://github.com/marlonrichert/zsh-snap.git $ZNAP_PATH

source $ZNAP_PATH/znap.zsh  # Start Znap

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# zstyle ':autocomplete:*' fzf-completion yes
zstyle ':autocomplete:*' recent-dirs zoxide
zstyle ':autocomplete:*' min-input 1
zstyle ':autocomplete:*' insert-unambiguous yes
zstyle ':autocomplete:*' widget-style menu-select


# znap source marlonrichert/zsh-autocomplete
znap source zsh-users/zsh-autosuggestions
znap source zsh-users/zsh-syntax-highlighting

zmodload zsh/zprof
export PATH=$HOME/bin:/usr/local/bin:/usr/local/sbin:$PATH
export MANPAGER=more

# fancy prompt
znap prompt sindresorhus/pure

# simple prompt
# autoload -U colors && colors	# Load colors
# PS1="%B%{$fg[red]%}[%{$fg[yellow]%}%n %{$fg[magenta]%}%~%{$fg[red]%}]%{$reset_color%}"$'\n'"$%b "

# znap prompt

# setopt autocd		# Automatically cd into typed directory.
# stty stop undef		# Disable ctrl-s to freeze terminal.
# setopt interactive_comments

export FZF_CTRL_T_COMMAND="fd --hidden --follow --exclude '.git' --exclude 'node_modules'"

# History in cache directory:
export HISTSIZE=1000000   # the number of items for the internal history list
export SAVEHIST=1000000   # maximum number of items for the history file

# The meaning of these options can be found in man page of `zshoptions`.
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_IGNORE_ALL_DUPS  # do not put duplicated command into history list
setopt HIST_SAVE_NO_DUPS  # do not save duplicated command
setopt HIST_REDUCE_BLANKS  # remove unnecessary blanks
setopt INC_APPEND_HISTORY_TIME  # append command to history file immediately after execution
setopt EXTENDED_HISTORY  # record command start time

# User configuration
ulimit -S -n 200048

bindkey "^B" beginning-of-line
bindkey "^E" end-of-line
bindkey "^P" up-line-or-history
bindkey "^N" down-line-or-history

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='nvim --clean -u ~/.vimrc'
fi

export XDG_CONFIG_HOME=$HOME/.config

# 10ms for key sequences
KEYTIMEOUT=10

source "/Users/david.sapiro/Library/Application Support/creds/nexus"

# Use vim keys in tab complete menu:
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history

if type brew &>/dev/null; then
  FPATH=$(brew --prefix)/share/zsh/site-functions:$FPATH
fi

# nnn
export NNN_PLUG='d:diff;v:imgview;p:preview-tui;z:autojump;e:dragdrop'
export NNN_FIFO=/tmp/nnn.fifo
BLK="04" CHR="04" DIR="04" EXE="00" REG="00" HARDLINK="00" SYMLINK="06" MISSING="00" ORPHAN="01" FIFO="0F" SOCK="0F" OTHER="02"
export NNN_FCOLORS="$BLK$CHR$DIR$EXE$REG$HARDLINK$SYMLINK$MISSING$ORPHAN$FIFO$SOCK$OTHER"

bindkey -s '^o' 'n\n'

n ()
{
    # Block nesting of nnn in subshells
    if [ -n $NNNLVL ] && [ "${NNNLVL:-0}" -ge 1 ]; then
        echo "nnn is already running"
        return
    fi

    # export NNN_TMPFILE to cdquit by default - now it is mapped to ^G
    NNN_TMPFILE="${XDG_CONFIG_HOME:-$HOME/.config}/nnn/.lastd"

    nnn "$@" -dH

    if [ -f "$NNN_TMPFILE" ]; then
            . "$NNN_TMPFILE"
            rm -f "$NNN_TMPFILE" > /dev/null
    fi
}

# C
export CC=/usr/local/Cellar/gcc/12.2.0/bin/gcc-12

# golang
export GOPATH=$HOME/dev/go
export GOROOT=/usr/local/opt/go/libexec
export PATH=$PATH:$GOPATH/bin
export PATH=$PATH:$GOROOT/bin

# erlang
export KERL_BUILD_DOCS="yes"

# python
export PYTHONBREAKPOINT=ipdb.set_trace
export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

venv() {
  export VENV_PATH=$(poetry env info --path)
}

# lua
znap function _luarocks luarocks 'eval "$(luarocks path --bin)"'
compctl -K    _luarocks luarocks

# Liquibase
export LIQUIBASE_HOME=/usr/local/opt/liquibase/libexec

export BAT_THEME="TwoDark"

codi() {
   local syntax="${1:-python}"
   shift
   nvim -c \
     "set bt=nofile ls=0 noru nonu nornu |\
     hi CodiVirtualText guifg=red
     hi ColorColumn ctermbg=NONE |\
     hi VertSplit ctermbg=NONE |\
     hi NonText ctermfg=0 |\
     Codi $syntax" "$@"
}

gcho() {
  local branches branch
  branches=$(git branch --all | grep -v HEAD) &&
  branch=$(echo "$branches" |
           fzf-tmux -d $(( 2 + $(wc -l <<< "$branches") )) +m) &&
  git checkout $(echo "$branch" | sed "s/.* //" | sed "s#remotes/[^/]*/##")
}

stag_pod_shell() {
  kubectx dev
  pod=$(kubectl -n development top pod --sort-by cpu | grep $1 | sort -k 2 | head -n1 | awk '{print $1}')
  kubectl -n development exec ${pod} -it -c ${2-main} -- bash;
}

prod_pod_shell () {
  kubectx prod-eu
  pod=$(kubectl -n production top pod --sort-by cpu | grep $1 | sort -k 2 | head -n1 | awk '{print $1}')
  kubectl -n production exec ${pod} -it -c ${2-main} -- bash;
}

pre_prod_pod_shell () {
  kubectx pre-prod
  pod=$(kubectl -n pre-prod top pod --sort-by cpu | grep $1 | sort -k 2 | head -n1 | awk '{print $1}')
  kubectl -n pre-prod exec ${pod} -it -c ${2-main} -- bash;
}

creds_aws_login_all() {
  creds aws login -n Development tf-engineers-role
  creds aws login -n Pre-Prod tf-oncall-role
  creds aws login -n Production tf-oncall-role
  creds aws login -n Silo tf-engineers-role
  export AWS_PROFILE=Development
}

secret_db_connection() {
  kubectl get secret $1 -o json | jq '.data | map_values(@base64d)' -r | jq '"postgres://\(.username):\(.password)@\(."read-host"):5432/\(.database)"' -r
}

# docker
DOCKER_CONFIG=$HOME/.config/docker

dca() {
  docker attach $(docker-compose ps -q $1)
}

dcsh() {
  docker exec -it $(docker-compose ps -q $1) bash
}

word() {
  rg $1 /usr/share/dict/words | fzf | pbcopy
}

diary() {
  cd ~/vimwiki/diary/
  nvim diary.wiki
}

dirsize() {
  for i in `ls -a`; do du -hs $i; done | sort -h
}

how() {
  language=$1
  query=("${(j.+.)@:2}")

  curl cht.sh/$language/$query
}

envup() {
  local file=$([ -z "$1" ] && echo ".env" || [ -f "$1" ] && echo $1 ||  echo ".env.$1")

  if [ -f $file ]; then
    set -a
    source $file
    set +a
  else
    echo "No $file file found" 1>&2
    return 1
  fi
}

eval "$(zoxide init zsh)"
eval "$(direnv hook zsh)"

# asdf
. /usr/local/opt/asdf/libexec/asdf.sh
fpath=(${ASDF_DIR}/completions $fpath)

# Aliases
alias cd=z
alias ls='exa'
alias ll='exa -lbsnew'
alias la='exa -lbasnew'
alias kk='k9s -c ctx'
alias kprod='k9s --context prod-eu'
alias kdev='k9s --context dev'
alias kpre='k9s --context pre-prod'
alias cat=bat
alias conf='cd ~/.config'
alias wiki='nvim -c VimwikiIndex'
alias lg=lazygit
alias cdr="cd $(git rev-parse --show-toplevel)"

# vim
alias p='nvim `fzf`'

# Git
alias gst='git status -sb'
alias gl='git pull'
alias gp='git push'
alias glg="git log --graph --pretty='%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --stat"

# Docker
alias dc='docker compose'
alias dcb='docker compose build'
alias dce='docker compose exec'
alias dcps='docker compose ps'
alias dcrm='docker compose rm'
alias dcr='docker compose run --rm'
alias dcstop='docker compose stop'
alias dcup='docker compose up -d'
alias dcdn='docker compose down'
alias dcpull='docker compose pull'
alias dcstart='docker compose start'

# jrnl
alias j='jrnl'
alias je='j --edit'
alias jel='je -1'
alias jo='jrnl --format fancy -on'
alias jot='jrnl --format fancy -on today'
alias joy='jrnl --format fancy -on yesterday'


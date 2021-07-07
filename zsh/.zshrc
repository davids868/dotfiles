export PATH=$HOME/bin:/usr/local/bin:$PATH

# fancy prompt
eval "$(starship init zsh)"
# simple prompt
# autoload -U colors && colors	# Load colors
# PS1="%B%{$fg[red]%}[%{$fg[yellow]%}%n%{$fg[green]%}@%{$fg[blue]%}%M %{$fg[magenta]%}%~%{$fg[red]%}]%{$reset_color%}$%b "
# setopt autocd		# Automatically cd into typed directory.
# stty stop undef		# Disable ctrl-s to freeze terminal.
# setopt interactive_comments

# History in cache directory:
HISTSIZE=10000000
SAVEHIST=10000000

# User configuration

bindkey "^B" beginning-of-line
bindkey "^E" end-of-line
bindkey "^P" up-line-or-history
bindkey "^N" down-line-or-history
bindkey -s '^o' 'n\n'

# bindkey -M viins 'kj' vi-cmd-mode
# bindkey -M viins 'jk' vi-cmd-mode
# bindkey -M <all vi modes> jk vi-movement-mode


# Change cursor shape for different vi modes.
# function zle-keymap-select () {
#     case $KEYMAP in
#         vicmd) echo -ne '\e[1 q';;      # block
#         viins|main) echo -ne '\e[5 q';; # beam
#     esac
# }
# zle -N zle-keymap-select
# zle-line-init() {
#     zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
#     echo -ne "\e[5 q"
# }
# zle -N zle-line-init
# echo -ne '\e[5 q' # Use beam shape cursor on startup.
# preexec() { echo -ne '\e[5 q' ;} # Use beam shape cursor for each new prompt.




# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='nvim'
fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

alias ranger='ranger --choosedir=$HOME/.rangerdir; LASTDIR=`cat $HOME/.rangerdir`; cd "$LASTDIR"'

# 10ms for key sequences
KEYTIMEOUT=1

source "/Users/david.sapiro/Library/Application Support/creds/nexus"

# tab completion
autoload -Uz compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots)
# Use vim keys in tab complete menu:
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history


# nnn
export NNN_PLUG='d:diff;v:imgview;p:preview-tui;z:autojump;e:dragdrop'
export NNN_FIFO=/tmp/nnn.fifo

n ()
{
    # Block nesting of nnn in subshells
    if [ -n $NNNLVL ] && [ "${NNNLVL:-0}" -ge 1 ]; then
        echo "nnn is already running"
        return
    fi

    # export NNN_TMPFILE to cdquit by default - now it is mapped to ^G
    NNN_TMPFILE="${XDG_CONFIG_HOME:-$HOME/.config}/nnn/.lastd"

    nnn "$@"

    if [ -f "$NNN_TMPFILE" ]; then
            . "$NNN_TMPFILE"
            rm -f "$NNN_TMPFILE" > /dev/null
    fi
}

# golang
export GOPATH=$HOME/dev/go
export GOROOT=/usr/local/opt/go/libexec
export PATH=$PATH:$GOPATH/bin
export PATH=$PATH:$GOROOT/bin

# erlang
export KERL_BUILD_DOCS="yes"

# python
export PYTHONBREAKPOINT=ipdb.set_trace
eval "$(pyenv init -)"

# ruby
eval "$(rbenv init -)"

# lua
eval "$(luarocks path --bin)"

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
  kubectl -n development exec -it $(kubectl -n development get pods | grep $1 | grep Running | head -n1 | awk '{print $1}') -c $1 bash;
}

prod_pod_shell () {
  kubectx prod-eu
  kubectl -n production exec -it $(kubectl -n production get pods | grep $1 | grep Running | head -n1 | awk '{print $1}') -c $1 bash;
}

pre_prod_pod_shell () {
  kubectx pre-prod
  kubectl -n pre-prod exec -it $(kubectl -n pre-prod get pods | grep $1 | grep Running | head -n1 | awk '{print $1}') -c $1 bash;
}

creds_aws_login_all() {
  creds aws login Development tf-engineers-role
  creds aws login -n Pre-Prod tf-oncall-role
  creds aws login -n Production tf-oncall-role
}

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
. /usr/local/opt/asdf/asdf.sh

# Aliases
alias ..='cd ..'
alias ...='cd ../..'
alias ls='exa'
alias ll='exa -lsnew'
alias la='exa -lasnew'
alias kk='k9s -c ctx'
# alias cat=bat
alias conf='cd ~/.config'
alias venv='export VIRTUAL_PYTHON_PATH=$(poetry env info --path)/bin/python'
alias wiki='nvim -c VimwikiIndex'
alias lg=lazygit
alias cdr="cd $(git rev-parse --show-toplevel)"
alias btm="btm --color=gruvbox --basic"

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
alias dcr='docker compose run'
alias dcstop='docker compose stop'
alias dcup='docker compose up'
alias dcdn='docker compose down'
alias dcpull='docker compose pull'
alias dcstart='docker compose start'


export PATH="$HOME/.poetry/bin:$PATH"

# Plugins
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
# source ~/.config/zsh/fzf-tab/fzf-tab.plugin.zsh
source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh

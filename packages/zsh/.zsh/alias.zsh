#        _ _
#   __ _| (_) __ _ ___
#  / _` | | |/ _` / __|
# | (_| | | | (_| \__ \
#  \__,_|_|_|\__,_|___/

# vim
alias vi="nvim"
alias vim="nvim"
alias view="nvim -R"

# git
alias g='git'
alias ga='git add'
alias gd='git diff'
alias gs='git status'
alias gp='git push'
alias gb='git branch'
alias gst='git status'
alias gco='git checkout'
alias gcob='git checkout -b'
alias gf='git fetch'
alias gc='git commit'
alias gcm='git commit -m'
alias gbdall='git branch -D $(git branch)'
alias gmc='gitmoji -c'
alias -g lb='`git branch | peco --prompt "GIT BRANCH>" | head -n 1 | sed -e "s/^\*\s*//g"`'

# docker
alias de='docker exec -it $(docker ps | peco | cut -d " " -f 1) /bin/bash'

# bat
alias cat='bat -pP'

# lsd
alias ls='lsd'

# cursor
alias c='cursor'

# dotfiles
alias dot='cursor ~/dotfiles'

# obsidian
alias ob='cursor ~/Library/Mobile\ Documents/iCloud~md~obsidian/Documents/Obsidian-iCloud'

# chage directory
if [[ -n $(echo ${^fpath}/chpwd_recent_dirs(N)) && -n $(echo ${^fpath}/cdr(N)) ]]; then
  autoload -Uz chpwd_recent_dirs cdr add-zsh-hook
  add-zsh-hook chpwd chpwd_recent_dirs
  zstyle ':completion:*' recent-dirs-insert both
  zstyle ':chpwd:*' recent-dirs-default true
  zstyle ':chpwd:*' recent-dirs-max 1000
  zstyle ':chpwd:*' recent-dirs-file "$HOME/.cache/chpwd-recent-dirs"
fi

function peco-cdr () {
  local selected_dir="$(cdr -l | sed 's/^[0-9]\+ \+//' | peco --prompt="cdr >" --layout top-down --query "$LBUFFER")"
  if [ -n "$selected_dir" ]; then
    BUFFER="cd `echo $selected_dir | awk '{print$2}'`"
    CURSOR=$#BUFFER
    zle reset-prompt
  fi
}
zle -N peco-cdr
bindkey '^G' peco-cdr

function select-task () {
  if [ -f "Taskfile.yml" ]; then
    task_name=$(task -a --json | jq -r '.tasks[].name' | peco)
  elif [ -f "turbo.json" ]; then
    task_name=$(cat turbo.json | jq -r '.tasks | keys[]' | peco)
  else
    echo "Taskfile.yml または turbo.json が見つかりません"
    return 1
  fi

  if [ -n "$task_name" ]; then
    if [ -f "Taskfile.yml" ]; then
      BUFFER="task $task_name"
    else
      BUFFER="pnpm run $task_name"
    fi
    CURSOR=$#BUFFER
    zle reset-prompt
  fi
}
zle -N select-task
bindkey '^T' select-task

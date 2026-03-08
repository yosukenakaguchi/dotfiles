#        _ _
#   __ _| (_) __ _ ___
#  / _` | | |/ _` / __|
# | (_| | | | (_| \__ \
#  \__,_|_|_|\__,_|___/

# alias名が既存コマンドと衝突する場合に警告を表示する
# 意図的な上書きは safe_alias! を使う
function safe_alias() {
  local force=false
  if [[ "$1" == "!" ]]; then
    force=true
    shift
  fi
  local alias_def="$1"
  local alias_name="${alias_def%%=*}"
  if ! $force && (( $+commands[$alias_name] )); then
    echo "\e[33m[safe_alias] warning: '$alias_name' overwrites an existing command ($(which $alias_name))\e[0m"
  fi
  alias "$alias_def"
}
alias safe_alias!='safe_alias !'

# vim
safe_alias! vi="nvim"
safe_alias! vim="nvim"
safe_alias! view="nvim -R"

# git
safe_alias g='git'
safe_alias ga='git add'
safe_alias gd='git diff'
safe_alias gs='git status'
safe_alias gp='git push'
safe_alias gb='git branch'
safe_alias gst='git status'
safe_alias gco='git checkout'
safe_alias gcob='git checkout -b'
safe_alias gf='git fetch'
safe_alias gc='git commit'
safe_alias gcm='git commit -m'
safe_alias gbdall='git branch -D $(git branch)'
safe_alias gmc='gitmoji -c'
alias -g lb='`git branch | peco --prompt "GIT BRANCH>" | head -n 1 | sed -e "s/^\*\s*//g"`'

# docker
safe_alias de='docker exec -it $(docker ps | peco | cut -d " " -f 1) /bin/bash'

# bat
safe_alias! cat='bat -pP'

# lsd
safe_alias! ls='lsd'

# # cursor
safe_alias c='cursor'

# dotfiles
safe_alias dot='cursor ~/dotfiles'

# obsidian
safe_alias ob='cursor ~/Library/Mobile\ Documents/iCloud~md~obsidian/Documents/Obsidian-iCloud'

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
  local tasks=()
  
  if [ -f "Taskfile.yml" ]; then
    while IFS= read -r task; do
      tasks+=("task: $task")
    done < <(task -a --json | jq -r '.tasks[].name')
  fi
  
  if [ -f "turbo.json" ]; then
    while IFS= read -r task; do
      tasks+=("turbo: $task")
    done < <(cat turbo.json | jq -r '.tasks | keys[]')
  fi

  if [ -f "package.json" ]; then
    local pm="npm"
    if [ -f "pnpm-lock.yaml" ]; then
      pm="pnpm"
    elif [ -f "yarn.lock" ]; then
      pm="yarn"
    elif [ -f "bun.lockb" ] || [ -f "bun.lock" ]; then
      pm="bun"
    fi
    while IFS= read -r task; do
      tasks+=("$pm: $task")
    done < <(cat package.json | jq -r '.scripts // {} | keys[]')
  fi

  if [ ${#tasks[@]} -eq 0 ]; then
    echo "Taskfile.yml, turbo.json, または package.json が見つかりません"
    return 1
  fi
  
  local selected=$(printf '%s\n' "${tasks[@]}" | peco)
  
  if [ -n "$selected" ]; then
    local prefix=$(echo "$selected" | cut -d: -f1)
    local task_name=$(echo "$selected" | cut -d' ' -f2-)

    if [ "$prefix" = "task" ]; then
      BUFFER="task $task_name"
    elif [ "$prefix" = "turbo" ]; then
      BUFFER="turbo run $task_name"
    else
      BUFFER="$prefix run $task_name"
    fi
    CURSOR=$#BUFFER
    zle reset-prompt
  fi
}
zle -N select-task
bindkey '^T' select-task

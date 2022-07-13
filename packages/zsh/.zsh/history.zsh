#  _     _     _
# | |__ (_)___| |_ ___  _ __ _   _
# | '_ \| / __| __/ _ \| '__| | | |
# | | | | \__ \ || (_) | |  | |_| |
# |_| |_|_|___/\__\___/|_|   \__, |
#                            |___/

export HISTFILE=~/.zsh_history # save of comannds history file
export HISTSIZE=20000          # on memory history size
export SAVEHIST=20000          # save history counts
setopt hist_ignore_all_dups    # ignore duplicate command
setopt inc_append_history      # to save every command
setopt hist_reduce_blanks      # remove duplicate spaces
setopt share_history           # share history between processes

function peco-select-history() {
  BUFFER=$(\history -n -r 1 | peco --query "$LBUFFER" --layout top-down)
  CURSOR=$#BUFFER
}
zle -N peco-select-history
bindkey '^R' peco-select-history

#  _       _ _
# (_)_ __ (_) |_
# | | '_ \| | __|
# | | | | | | |_
# |_|_| |_|_|\__|

eval "$(starship init zsh)"

if type brew &>/dev/null; then
  FPATH=$(brew --prefix)/share/zsh-completions:$FPATH
  source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
  source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

  autoload -Uz compinit
  compinit
fi

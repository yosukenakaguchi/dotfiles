#  _       _ _
# (_)_ __ (_) |_
# | | '_ \| | __|
# | | | | | | |_
# |_|_| |_|_|\__|

eval "$(starship init zsh)"

. /opt/homebrew/opt/asdf/libexec/asdf.sh

if type brew &>/dev/null; then
  FPATH=$(brew --prefix)/share/zsh-completions:$FPATH
  source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh

  autoload -Uz compinit
  compinit
fi

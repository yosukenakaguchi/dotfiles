[![Installation and Setup Check](https://github.com/yosukenakaguchi/dotfiles/actions/workflows/setup.yaml/badge.svg)](https://github.com/yosukenakaguchi/dotfiles/actions/workflows/setup.yaml)
[![Shellcheck](https://github.com/yosukenakaguchi/dotfiles/actions/workflows/shellcheck.yaml/badge.svg)](https://github.com/yosukenakaguchi/dotfiles/actions/workflows/shellcheck.yaml)

# dotfiles

This dotfiles for macOS are managed with [Homebrew Bundle](https://github.com/Homebrew/homebrew-bundle), [GNU stow](https://www.gnu.org/software/stow/).

- Shell: Z shell
- Terminal: [Alacritty](https://alacritty.org/) with [tmux](https://github.com/tmux/tmux) and [Starship](https://starship.rs/)
- Editor: [VSCode](https://azure.microsoft.com/en-us/products/visual-studio-code/) with [VSCode Neovim](https://github.com/vscode-neovim/vscode-neovim)

## Installation

```
$ git clone https://github.com/yosukenakaguchi/dotfiles.git .
$ cd ~/dotfiles
$ make all
```

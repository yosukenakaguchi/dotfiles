.PHONY: stow-packages
stow-packages:
	@echo	"------------Start updating dotfiles symbolic link.------------"
	@./scripts/stow_packages.sh
	@echo "--------------------Finished Successfully.--------------------"

.PHONY: asdf-plugins
asdf-plugins:
	@./scripts/asdf_plugins.sh

.PHONY: brew-bundle
brew-bundle:
	brew bundle install --verbose --no-lock --file=./packages/brewfiles/.Brewfile

.PHONY: brew-bundle-mas
brew-bundle-mas:
	brew bundle install --verbose --no-lock --file=./packages/brewfiles/.Brewfile.mas

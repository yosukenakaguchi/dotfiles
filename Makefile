PHONY: all
all:
	initialize brew-bundle brew-bundle-mas asdf-plugins stow-packages

PHONY: initialize
initialize:
	@./scripts/initialize.sh

.PHONY: brew-bundle
brew-bundle:
	brew bundle install --verbose --no-lock --file=./packages/brewfiles/.Brewfile

.PHONY: brew-bundle-mas
brew-bundle-mas:
	brew bundle install --verbose --no-lock --file=./packages/brewfiles/.Brewfile.mas

.PHONY: brew-bundle-ci
brew-bundle-ci:
	grep -Ev "awscli|cocoapods" ./packages/brewfiles/.Brewfile > ./packages/brewfiles/.Brewfile.ci
	brew bundle --verbose --no-lock --file=./packages/brewfiles/.Brewfile.ci

.PHONY: asdf-plugins
asdf-plugins:
	@./scripts/asdf_plugins.sh

.PHONY: stow-packages
stow-packages:
	@echo	"------------Start updating dotfiles symbolic link.------------"
	@./scripts/stow_packages.sh
	@echo "--------------------Finished Successfully.--------------------"

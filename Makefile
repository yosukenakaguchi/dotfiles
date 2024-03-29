PHONY: all
all:
	initialize brew-bundle brew-bundle-mas stow-packages @cmatrix

PHONY: initialize
initialize:
	@./scripts/initialize.sh

.PHONY: brew-bundle
brew-bundle:
	brew bundle --verbose --no-lock --file=./packages/brewfiles/.Brewfile
	@terminal-notifier -title 'make brew-bundle' -message 'Finished!' -execute 'open /Applications/Alacritty.app'

.PHONY: brew-bundle-mas
brew-bundle-mas:
	brew bundle --verbose --no-lock --file=./packages/brewfiles/.Brewfile.mas

.PHONY: brew-bundle-ci
brew-bundle-ci:
	grep -Ev "awscli|cocoapods" ./packages/brewfiles/.Brewfile > ./packages/brewfiles/.Brewfile.ci
	brew bundle --verbose --no-lock --file=./packages/brewfiles/.Brewfile.ci

.PHONY: stow-packages
stow-packages:
	@echo	"------------Start updating dotfiles symbolic link.------------"
	@./scripts/stow_packages.sh
	@echo "--------------------Finished Successfully.--------------------"

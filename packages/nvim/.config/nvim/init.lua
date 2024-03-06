require('base.options')
require('base.keymaps')
require('lazy-config')

if vim.g.vscode then
  require "hop-config"
end
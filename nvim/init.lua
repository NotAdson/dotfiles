-- Neovim 0.11+ Compatibility Shims (must be at the top)
if vim.treesitter and not vim.treesitter.ft_to_lang then
  vim.treesitter.ft_to_lang = function(ft)
    return (vim.treesitter.language and vim.treesitter.language.get_lang(ft)) or ft
  end
end

require("plugins")
require("plugins_config")
require("keymaps")

-- UI Settings
vim.opt.termguicolors = true

-- Line numbers
vim.opt.number = true
vim.opt.relativenumber = false

-- Set font to Departure
vim.opt.guifont = "Departure:h12"

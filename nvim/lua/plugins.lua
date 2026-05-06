local ensure_packer = function()
	local fn = vim.fn
	local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
	if fn.empty(fn.glob(install_path)) > 0 then
		fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
		vim.cmd [[packadd packer.nvim]]
		return true
	end
	return false
end

local packer_bootstrap = ensure_packer()

return require('packer').startup(function(use)
	use 'wbthomason/packer.nvim'
	use 'nvim-tree/nvim-tree.lua'
	use 'nvim-lualine/lualine.nvim'
	use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
	use 'neovim/nvim-lspconfig' -- Basic LSP support
	use 'williamboman/mason.nvim' -- Install LSP servers easily
	use 'williamboman/mason-lspconfig.nvim' -- Bridge for mason and lspconfig
	use 'hrsh7th/nvim-cmp' -- Completion engine
	use 'hrsh7th/cmp-nvim-lsp' -- LSP source for nvim-cmp
	use 'hrsh7th/cmp-buffer' -- Buffer completions
	use 'hrsh7th/cmp-path' -- Path completions
	use 'L3MON4D3/LuaSnip' -- Snippet engine (optional)
	use 'saadparwaiz1/cmp_luasnip' -- Snippet completions

	use 'nvimtools/none-ls.nvim' -- For linters and formatters
	use 'jay-babu/mason-null-ls.nvim' -- Bridge for mason and none-ls

	use({
		"AlphaTechnolog/pywal.nvim",
		as = 'pywal',
		config = function()
			require("pywal").setup()
		end,
	})

	use {
		'nvim-tree/nvim-web-devicons',
		config = function()
			require'nvim-web-devicons'.setup {}
		end
	}

	use {
	  'nvim-telescope/telescope.nvim',
	  requires = { {'nvim-lua/plenary.nvim'} }
	}

	use {
	  "folke/which-key.nvim",
	  config = function()
	    vim.o.timeout = true
	    vim.o.timeoutlen = 300
	    require("which-key").setup {}
	  end
	}

	use({
	  'zbirenbaum/copilot.lua',
	  cmd = { 'Copilot', 'CopilotSetup' },
	  event = 'InsertEnter',
	  config = function()
	    require('copilot').setup({
	      -- disable floating window, let cmp handle suggestions
	      suggestion = {
                enabled = true,
                auto_trigger = true,
                keymap = {
                    accept = "<Tab>",
                },
              },
	      panel = { enabled = true },
              filetypes = {
                ["*"] = false,
                python = true,
              },
	    })
	  end,
	})

	use({
	  'zbirenbaum/copilot-cmp',
	  after = { 'copilot.lua' },
	  config = function()
	    require('copilot_cmp').setup()
	  end,
	})

	if packer_bootstrap then
		require('packer').sync()
	end
end)

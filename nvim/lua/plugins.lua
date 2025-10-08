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
	use 'nvim-treesitter/nvim-treesitter'
	use 'neovim/nvim-lspconfig' -- Basic LSP support
	use 'williamboman/mason.nvim' -- Install LSP servers easily
	use 'williamboman/mason-lspconfig.nvim' -- Bridge for mason and lspconfig
	use 'hrsh7th/nvim-cmp' -- Completion engine
	use 'hrsh7th/cmp-nvim-lsp' -- LSP source for nvim-cmp
	use 'L3MON4D3/LuaSnip' -- Snippet engine (optional)

	use({
		"neanias/everforest-nvim",
		config = function()
			require("everforest").setup()
		end,
	})

	use {
		'nvim-tree/nvim-web-devicons',
		config = function()
			require'nvim-web-devicons'.setup {}
		end
	}

	use {
		'nvim-telescope/telescope.nvim', tag = '0.1.8',
		requires = { {'nvim-lua/plenary.nvim'} }
	}

	use({
	  'zbirenbaum/copilot.lua',
	  cmd = { 'Copilot', 'CopilotSetup' },
	  event = 'InsertEnter',
	  config = function()
	    require('copilot').setup({
	      -- disable floating window, let cmp handle suggestions
	      suggestion = { enabled = true },
	      panel = { enabled = true },
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

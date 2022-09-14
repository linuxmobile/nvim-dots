local fn = vim.fn

-- █ █▄░█ █▀ ▀█▀ ▄▀█ █░░ █░░   █▀█ ▄▀█ █▀▀ █▄▀ █▀▀ █▀█
-- █ █░▀█ ▄█ ░█░ █▀█ █▄▄ █▄▄   █▀▀ █▀█ █▄▄ █░█ ██▄ █▀▄
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
	PACKER_BOOTSTRAP = fn.system({
		"git",
		"clone",
		"--depth",
		"1",
		"https://github.com/wbthomason/packer.nvim",
		install_path,
	})
	print("Installing packer close and reopen Neovim...")
	vim.cmd([[packadd packer.nvim]])
end

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
	return
end

-- █▀█ ▄▀█ █▀▀ █▄▀ █▀▀ █▀█   █▀█ █▀█ █▀█ █░█ █▀█
-- █▀▀ █▀█ █▄▄ █░█ ██▄ █▀▄   █▀▀ █▄█ █▀▀ █▄█ █▀▀
packer.init({
	display = {
		open_fn = function()
			return require("packer.util").float({ border = "rounded" })
		end,
	},
})

return packer.startup(function(use)
	use({
		"lewis6991/impatient.nvim",
		config = function()
			require("impatient")
		end,
	})
    use("wbthomason/packer.nvim") -- Have packer manage itself
	use({
		'rose-pine/neovim',
		as = 'rose-pine',
		tag = 'v1.*',
		config = function()
			vim.cmd('colorscheme rose-pine')
		end
	})
	use("nvim-lua/plenary.nvim") -- Useful lua functions used ny lots of plugins
	use('nvim-lualine/lualine.nvim') -- Statusline
	use 'onsails/lspkind-nvim' -- vscode-like pictograms
	use 'hrsh7th/cmp-buffer' -- nvim-cmp source for buffer words
	use 'hrsh7th/cmp-nvim-lsp' -- nvim-cmp source for neovim's built-in LSP
	use 'hrsh7th/nvim-cmp' -- Completion
	use 'neovim/nvim-lspconfig' -- LSP
	use 'jose-elias-alvarez/null-ls.nvim' -- Use Neovim as a language server to inject LSP diagnostics, code actions, and more via Lua
	use 'MunifTanjim/prettier.nvim' -- Prettier plugin for Neovim's built-in LSP client
	use 'williamboman/mason.nvim'
	use 'williamboman/mason-lspconfig.nvim'

	use 'glepnir/lspsaga.nvim' -- LSP UIs
	use 'L3MON4D3/LuaSnip'
	use {
		'nvim-treesitter/nvim-treesitter',
		run = function() require('nvim-treesitter.install').update({ with_sync = true }) end,
	  }
	use 'kyazdani42/nvim-web-devicons' -- File icons
	use 'nvim-telescope/telescope.nvim'
	use 'nvim-telescope/telescope-file-browser.nvim'
	use 'windwp/nvim-autopairs'
	use 'windwp/nvim-ts-autotag'
	use 'norcalli/nvim-colorizer.lua'
	use 'folke/zen-mode.nvim'
	use({
		"iamcco/markdown-preview.nvim",
		run = function() vim.fn["mkdp#util#install"]() end,
	  })
	use 'akinsho/nvim-bufferline.lua'
	use 'lewis6991/gitsigns.nvim'
	use 'dinhhuy258/git.nvim' -- For git blame & browse
	use 'lukas-reineke/indent-blankline.nvim'
	use 'm-demare/hlargs.nvim'
	use 'antoinemadec/FixCursorHold.nvim'
	use 'rcarriga/nvim-notify'
	use 'RRethy/vim-illuminate'
	use 'simrat39/symbols-outline.nvim' -- Tree like view for symbols in Neovim
	use 'numToStr/Comment.nvim'
	use 'folke/which-key.nvim'
	use 'andweeb/presence.nvim'
    -- Automatically set up your configuration after cloning packer.nvim
	-- Put this at the end after all plugins
	if PACKER_BOOTSTRAP then
		require("packer").sync()
	end
end)

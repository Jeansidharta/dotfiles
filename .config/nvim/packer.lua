return require('packer').startup(function(use)
	use 'wbthomason/packer.nvim'
	use { 'tomasiser/vim-code-dark' }
	use { 'kyazdani42/nvim-web-devicons' }
	use {
	  'nvim-telescope/telescope.nvim', tag = '0.1.0',
	  requires = { {'nvim-lua/plenary.nvim'} }
	}
	use { "nvim-telescope/telescope-file-browser.nvim" }
	use { 'norcalli/nvim-colorizer.lua' }
	use { "sbdchd/neoformat" }
	use {'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
	use {
		'nvim-treesitter/nvim-treesitter',
		run = ':TSUpdate'
	}
	use { 'rcarriga/nvim-notify' }
	use { 'easymotion/vim-easymotion' }
	-- use { "rebelot/heirline.nvim" }
	use 'neovim/nvim-lspconfig'
	use({
  "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
		config = function()
			require("lsp_lines").setup()
		end,
	})
	use 'lewis6991/gitsigns.nvim'
	use {"petertriho/nvim-scrollbar"}
	use { "nvim-lualine/lualine.nvim" }
	use { 'ms-jpq/coq_nvim', branch ='coq' }
	use {'ms-jpq/coq.artifacts', branch = 'artifacts' }
	use {'ms-jpq/coq.thirdparty', branch= '3p'}
    use {'stevearc/dressing.nvim'}
    use {'unblevable/quick-scope'}
    use {'tpope/vim-fugitive'}
    use {
      'stevearc/overseer.nvim',
      config = function() require('overseer').setup() end
    }
end)

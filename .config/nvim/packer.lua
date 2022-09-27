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
	use { 'j-hui/fidget.nvim' }
	use({
    "kylechui/nvim-surround",
    tag = "*", -- Use for stability; omit to use `main` branch for the latest features
    config = function()
    end
	})
	use {
		"AckslD/nvim-neoclip.lua",
		requires = {
			{'kkharji/sqlite.lua', module = 'sqlite'},
			{'nvim-telescope/telescope.nvim'},
		}
	}
	use 'sunjon/shade.nvim'
	use {
		"winston0410/range-highlight.nvim",
		requires = {
			{'winston0410/cmd-parser.nvim'},
		}
	}
	use "numToStr/FTerm.nvim"
	use {'akinsho/git-conflict.nvim', tag = "*" }
	use 'karb94/neoscroll.nvim'
	use 'tpope/vim-repeat'
	use {
		'glts/vim-radical',
		requires = {
			{'glts/vim-magnum'}
		}
	}
	use 'chentoast/marks.nvim'
	use {
		'phaazon/hop.nvim',
		branch = 'v2', -- optional but strongly recommended
		config = function()
		-- you can configure Hop the way you like here; see :h hop-config
		require'hop'.setup { keys = 'etovxqpdygfblzhckisuran' }
		end
	}
	use { 'numToStr/Comment.nvim' }
    use "lukas-reineke/lsp-format.nvim"
end)

return require("packer").startup(function(use)
	use("wbthomason/packer.nvim")
	use({ "tomasiser/vim-code-dark" })
	use({ "kyazdani42/nvim-web-devicons" })
	use({
		"nvim-telescope/telescope.nvim",
		tag = "0.1.0",
		requires = { { "nvim-lua/plenary.nvim" } },
	})
	use({ "nvim-telescope/telescope-file-browser.nvim" })
	use({ "norcalli/nvim-colorizer.lua" })
	use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" })
	use({
		"nvim-treesitter/nvim-treesitter",
		run = ":TSUpdate",
	})
	use({ "rcarriga/nvim-notify" })
	use("neovim/nvim-lspconfig")
	use("lewis6991/gitsigns.nvim")
	use({ "petertriho/nvim-scrollbar" })
	use({ "nvim-lualine/lualine.nvim" })
	use({ "stevearc/dressing.nvim" })
	use({ "tpope/vim-fugitive" })
	use({
		"stevearc/overseer.nvim",
		config = function()
			require("overseer").setup()
		end,
	})
	use({ "j-hui/fidget.nvim" })
	use({
		"kylechui/nvim-surround",
		tag = "*", -- Use for stability; omit to use `main` branch for the latest features
		config = function() end,
	})
	use({
		"AckslD/nvim-neoclip.lua",
		requires = {
			{ "kkharji/sqlite.lua", module = "sqlite" },
			{ "nvim-telescope/telescope.nvim" },
		},
	})
	use("sunjon/shade.nvim")
	use({
		"winston0410/range-highlight.nvim",
		requires = {
			{ "winston0410/cmd-parser.nvim" },
		},
	})
	use("numToStr/FTerm.nvim")
	use({ "akinsho/git-conflict.nvim", tag = "*" })
	use("karb94/neoscroll.nvim")
	use("tpope/vim-repeat")
	use({
		"glts/vim-radical",
		requires = {
			{ "glts/vim-magnum" },
		},
	})
	use("chentoast/marks.nvim")
	use({
		"phaazon/hop.nvim",
		branch = "v2", -- optional but strongly recommended
	})
	use({ "numToStr/Comment.nvim" })
	use({ "jeansidharta/tokyodark.nvim" })
	use({ "mhartington/formatter.nvim" })
	use({ "Jeansidharta/telescope-git" })
	use({
		"rest-nvim/rest.nvim",
		requires = { "nvim-lua/plenary.nvim" },
	})
	use({ "Jeansidharta/duck.nvim" })

	-- Autocomplete
	use({ "hrsh7th/cmp-nvim-lsp" })
	use({ "hrsh7th/cmp-buffer" })
	use({ "hrsh7th/cmp-path" })
	use({ "hrsh7th/cmp-cmdline" })
	use({ "hrsh7th/nvim-cmp" })
	use({ "lewis6991/hover.nvim" })
	use({ "saadparwaiz1/cmp_luasnip" })

	use({ "michaelb/sniprun", run = "bash ./install.sh" })
	use({ "lukas-reineke/indent-blankline.nvim" })
	use({ "RRethy/vim-illuminate" })
	use({ "L3MON4D3/LuaSnip", tag = "v<CurrentMajor>.*" })
end)

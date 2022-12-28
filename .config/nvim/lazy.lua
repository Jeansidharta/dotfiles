return require("lazy").setup({
	"wbthomason/packer.nvim",
	"tomasiser/vim-code-dark",
	"kyazdani42/nvim-web-devicons",
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.0",
		dependencies = { "nvim-lua/plenary.nvim" },
	},
	"nvim-telescope/telescope-file-browser.nvim",
	"norcalli/nvim-colorizer.lua",
	{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
	},
	"rcarriga/nvim-notify",
	"neovim/nvim-lspconfig",
	"lewis6991/gitsigns.nvim",
	"petertriho/nvim-scrollbar",
	"nvim-lualine/lualine.nvim",
	"stevearc/dressing.nvim",
	"tpope/vim-fugitive",
	{
		"stevearc/overseer.nvim",
		config = function()
			require("overseer").setup()
		end,
	},
	"j-hui/fidget.nvim",
	"kylechui/nvim-surround",
	{
		"AckslD/nvim-neoclip.lua",
		dependencies = {
			"kkharji/sqlite.lua",
			"nvim-telescope/telescope.nvim",
		},
	},
	"sunjon/shade.nvim",
	{
		"winston0410/range-highlight.nvim",
		dependencies = {
			"winston0410/cmd-parser.nvim",
		},
	},
	"numToStr/FTerm.nvim",
	"akinsho/git-conflict.nvim",
	"karb94/neoscroll.nvim",
	"tpope/vim-repeat",
	{
		"glts/vim-radical",
		dependencies = {
			"glts/vim-magnum",
		},
	},
	"chentoast/marks.nvim",
	{
		"phaazon/hop.nvim",
		branch = "v2", -- optional but strongly recommended
	},
	"numToStr/Comment.nvim",
	"jeansidharta/tokyodark.nvim",
	"mhartington/formatter.nvim",
	"Jeansidharta/telescope-git",
	{
		"rest-nvim/rest.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
	},
	"Jeansidharta/duck.nvim",

	-- Autocomplete
	"hrsh7th/cmp-nvim-lsp",
	"hrsh7th/cmp-buffer",
	"hrsh7th/cmp-path",
	"hrsh7th/cmp-cmdline",
	"hrsh7th/nvim-cmp",
	"lewis6991/hover.nvim",
	"saadparwaiz1/cmp_luasnip",

	{ "michaelb/sniprun", build = "bash ./install.sh" },
	"lukas-reineke/indent-blankline.nvim",
	"RRethy/vim-illuminate",
	{ "L3MON4D3/LuaSnip" },
	{
		"cbochs/grapple.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
	},
})

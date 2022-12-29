return {
	{
		"jeansidharta/tokyodark.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			-- load the colorscheme here
			vim.cmd([[colorscheme tokyodark]])
		end,
	},
	"tomasiser/vim-code-dark",
	"kyazdani42/nvim-web-devicons",

	{
		"nvim-telescope/telescope-file-browser.nvim",
		dependencies = {
			"nvim-telescope/telescope.nvim",
		},
		lazy = false,
		config = function()
			require("telescope").load_extension("file_browser")
		end,
	},

	{ "norcalli/nvim-colorizer.lua", config = true, event = "BufReadPost" },

	{
		"rcarriga/nvim-notify",
		dependencies = {
			"nvim-telescope/telescope.nvim",
		},
		event = "VeryLazy",
		config = function()
			require("telescope").load_extension("notify")
			vim.notify = require("notify")
		end,
	},
	{ "j-hui/fidget.nvim", config = true, event = "BufEnter" },
	{ "kylechui/nvim-surround", config = true, event = "VeryLazy" },
	{ "numToStr/Comment.nvim", config = true, keys = {
		"gcc",
		"gbc",
	} },
	{ "tpope/vim-fugitive", event = "BufEnter" },
	{ "karb94/neoscroll.nvim", config = true, event = "VeryLazy" },
	{ "akinsho/git-conflict.nvim", config = true, event = "BufReadPre" },
	{
		"Jeansidharta/telescope-git",
		dependencies = {
			"nvim-telescope/telescope.nvim",
		},
		config = function()
			require("telescope").load_extension("telescope_git")
		end,
	},
	{
		"Jeansidharta/duck.nvim",
		config = function()
			vim.keymap.set("n", "<leader>dd", function()
				require("duck").hatch("D")
			end, {})
			vim.keymap.set("n", "<leader>dk", function()
				require("duck").cook()
			end, {})
		end,
	},

	{
		"glts/vim-radical",
		dependencies = {
			"glts/vim-magnum",
		},
		keys = { "gA", "crd", "crx", "cro", "crb" },
	},
	{
		"winston0410/range-highlight.nvim",
		event = "VeryLazy",
		dependencies = {
			"winston0410/cmd-parser.nvim",
		},
		config = true,
	},
}

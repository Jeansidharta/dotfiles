return {
	{
		"jeansidharta/tokyodark.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			-- load the colorscheme here
			vim.g.tokyodark_transparent_background = true
			vim.cmd([[colorscheme tokyodark]])
		end,
	},
	"tomasiser/vim-code-dark",
	{ "kyazdani42/nvim-web-devicons", name = "web-devicons" },

	{ "norcalli/nvim-colorizer.lua", config = true, event = "BufReadPost" },

	{
		"rcarriga/nvim-notify",
		dependencies = {
			"nvim-telescope/telescope.nvim",
		},
		event = "VeryLazy",
		config = function()
			require("telescope").load_extension("notify")
			require("notify").setup({ background_colour = "#000000" })
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
	{
		url = "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
		event = "BufReadPost",
		config = function()
			require("lsp_lines").setup()
			vim.diagnostic.config({
				virtual_lines = false,
			})
		end,
		keys = {
			{
				"<leader>dl",
				function()
					local is_lines_set = vim.diagnostic.config().virtual_lines
					if is_lines_set then
						vim.diagnostic.config({
							virtual_lines = false,
							virtual_text = true,
						})
					else
						vim.diagnostic.config({
							virtual_lines = true,
							virtual_text = false,
						})
					end
				end,
				desc = "Toggle lsp_lines",
			},
		},
	},
	{ "EtiamNullam/deferred-clipboard.nvim", lazy = false, config = true },
	{ "chrisgrieser/nvim-various-textobjs", event = "VeryLazy", config = {
		useDefaultKeymaps = true,
	} },
	"elkowar/yuck.vim",
	{
		-- "stevearc/oil.nvim",
		dir = "~/projects/personal/vim-plugins/oil.nvim",
		config = {
			columns = {
				"icon",
				-- "permissions",
				"size",
				-- "mtime",
			},
			view_options = {
				show_hidden = true,
			},
		},
		lazy = false,
		keys = {
			{
				"-",
				function()
					require("oil").open()
				end,
				desc = "Open parent directory",
			},
		},
	},

	{
		"weilbith/nvim-code-action-menu",
		cmd = "CodeActionMenu",
		keys = {
			{ "<leader>a", ":CodeActionMenu<CR>", noremap = true, desc = "Open code action menu" },
		},
	},
	{
		dir = "~/projects/personal/vim-plugins/binary-windows.nvim",
		event = "VeryLazy",
		config = true,
	},
	{
		"folke/trouble.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("trouble").setup({})
		end,
	},
	-- { "RaafatTurki/hex.nvim", config = true, lazy = false },
	{ "nvim-treesitter/playground", lazy = false },
	{
		dir = "~/projects/personal/vim-plugins/text-image",
		lazy = false,
		config = {
			client = "chafa",
			auto_open_on_image = true,
		},
	},
	{
		"simrat39/rust-tools.nvim",
		lazy = false,
		config = function()
			local rt = require("rust-tools")

			rt.setup({
				server = {
					on_attach = function(_, bufnr)
						-- Hover actions
						vim.keymap.set("n", "<C-space>", rt.hover_actions.hover_actions, { buffer = bufnr })
						-- Code action groups
						-- vim.keymap.set("n", "<Leader>a", rt.code_action_group.code_action_group, { buffer = bufnr })

						local bufopts = function(desc)
							return { noremap = true, silent = true, buffer = bufnr, desc = desc }
						end
						vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts("Go to declaration"))
						vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts("Go to definition"))
						vim.keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts("Go to implementation"))
						vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, bufopts("Signature help"))
						vim.keymap.set(
							"n",
							"<space>wa",
							vim.lsp.buf.add_workspace_folder,
							bufopts("Add workspace folder")
						)
						vim.keymap.set(
							"n",
							"<space>wr",
							vim.lsp.buf.remove_workspace_folder,
							bufopts("Remove workspace folder")
						)
						vim.keymap.set("n", "<space>wl", function()
							print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
						end, bufopts("List workspace folders"))
						vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition, bufopts("Go to type definition"))
						vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, bufopts("Rename symbol"))
						vim.keymap.set("n", "<space>ca", vim.lsp.buf.code_action, bufopts("Code action"))
						vim.keymap.set("n", "gr", vim.lsp.buf.references, bufopts("Go to references"))

						rt.inlay_hints.enable()
					end,
				},
			})
		end,
	},
	{
		"mickael-menu/zk-nvim",
		lazy = false,
		keys = {
			{
				"<leader>/n",
				"<Cmd>ZkNew { title = vim.fn.input('Title: ') }<CR>",
				noremap = true,
				desc = "Create new ZK note",
			},
			{ "<leader>/t", "<Cmd>ZkTags<CR>", noremap = true, desc = "Search for ZK tags" },
			{ "<leader>/o", "<Cmd>ZkNotes { sort = { 'modified' } }<CR>", noremap = true, desc = "Open ZK notes" },
			{
				"<leader>/f",
				"<Cmd>ZkNotes { sort = { 'modified' }, match = { vim.fn.input('Search: ') } }<CR>",
				noremap = true,
				desc = "Find ZK note",
			},
			{
				"<leader>/f",
				":'<,'>ZkMatch<CR>",
				noremap = true,
				mode = "v",
				desc = "Find ZK note",
			},
		},
		config = function()
			require("zk").setup({
				picker = "telescope",

				lsp = {
					-- `config` is passed to `vim.lsp.start_client(config)`
					config = {
						cmd = { "zk", "lsp" },
						name = "zk",
						-- on_attach = ...
						-- etc, see `:h vim.lsp.start_client()`
					},

					-- automatically attach buffers in a zk notebook that match the given filetypes
					auto_attach = {
						enabled = true,
						filetypes = { "markdown" },
					},
				},
			})
		end,
	},
	{ "lukas-reineke/virt-column.nvim", lazy = false, config = { char = "▏" } },
	{
		"luukvbaal/statuscol.nvim",
		config = function()
			local builtin = require("statuscol.builtin")
			require("statuscol").setup({
				-- configuration goes here, for example:
				relculright = true,
				segments = {
					{ text = { builtin.foldfunc }, click = "v:lua.ScFa" },
					{
						sign = { name = { "Diagnostic" }, maxwidth = 2, auto = true },
						click = "v:lua.ScSa",
					},
					{ text = { builtin.lnumfunc }, click = "v:lua.ScLa" },
					{
						sign = { name = { ".*" }, maxwidth = 2, colwidth = 1, auto = true },
						click = "v:lua.ScSa",
					},
				},
			})
		end,
	},
	{
		dir = "~/projects/personal/vim-plugins/telescope-misc",
		lazy = false,
		dependencies = {
			"nvim-telescope/telescope.nvim",
		},
		config = function()
			require("telescope").load_extension("telescope-misc")
		end,

		keys = {
			{
				"<leader>te",
				function()
					require("telescope-misc").extensions({}, "telescope-misc")
				end,
				desc = "Telescope open extension",
				noremap = true,
			},
			{
				"<leader>ts",
				function()
					require("telescope-misc").syntax()
				end,
				desc = "Telescope open extension",
				noremap = true,
			},
		},
	},
	-- {
	-- 	"wuelnerdotexe/vim-astro",
	-- 	lazy = false,
	-- 	config = function()
	-- 		vim.g.astro_typescript = "enabled"
	-- 		vim.g.astro_stylus = "enabled"
	-- 	end,
	-- },
}

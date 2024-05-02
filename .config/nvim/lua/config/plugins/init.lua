return {
	{
		"jeansidharta/tokyodark.nvim",
		lazy = false,
		dev = true,
		priority = 1000,
		config = function()
			-- load the colorscheme here
			vim.g.tokyodark_transparent_background = true
			vim.cmd([[colorscheme tokyodark]])
		end,
	},
	-- Backup theme
	-- "tomasiser/vim-code-dark",
	{ "kyazdani42/nvim-web-devicons", name = "web-devicons" },
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
	-- { "kylechui/nvim-surround",       config = true,        event = "VeryLazy" },
	{
		"numToStr/Comment.nvim",
		dev = true,
		config = true,
		keys = {
			"gcc",
			"gbc",
		},
	},
	{ "tpope/vim-fugitive",           event = "BufEnter" },
	{ "akinsho/git-conflict.nvim",    config = true,        event = "BufReadPre" },
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
	{
		"chrisgrieser/nvim-various-textobjs",
		event = "VeryLazy",
		config = {
			useDefaultKeymaps = true,
		},
	},
	{
		"stevearc/oil.nvim",
		config = {
			columns = {
				"icon",
				-- "permissions",
				"size",
				-- "mtime",
			},
			view_options = {
				show_hidden = true,
				is_always_hidden = function(name, bufnr)
					return name == ".."
				end,
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
		"folke/trouble.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("trouble").setup({})
		end,
	},
	{
		"simrat39/rust-tools.nvim",
		lazy = false,
		config = function()
			local rt = require("rust-tools")

			rt.setup({
				server = {
					settings = {
						["rust-analyzer"] = {
							checkOnSave = {
								enable = true,
								command = "clippy",
							},
							cargo = {
								allFeatures = true,
							},
							hover = { actions = { references = { enable = true } } },
							imports = { granularity = { enforce = true } },
							inlayHints = {
								maxLength = nil,
								reborrowHints = { enable = "always" },
								expressionAdjustmentHints = { enable = "always" },
								discriminantHints = { enable = "always" },
								closureReturnTypeHints = { enable = "always" },
								closureCaptureHints = { enable = true },
								bindingModeHints = { enable = true },
							},
						},
					},
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
						vim.keymap.set("n", "<space>a", vim.lsp.buf.code_action, bufopts("Code action"))
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
			{ "<leader>/t", "<Cmd>ZkTags<CR>",                            noremap = true, desc = "Search for ZK tags" },
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
					config = {
						cmd = { "zk", "lsp" },
						name = "zk",
					},
					auto_attach = {
						enabled = true,
						filetypes = { "markdown" },
					},
				},
			})
		end,
	},
	{ "elkowar/yuck.vim",                    lazy = false },
	{
		"gpanders/nvim-parinfer",
		lazy = false,
		config = function()
			vim.g.parinfer_mode = "smart"
		end,
	},
	{
		"gbprod/substitute.nvim",
		config = true,
		keys = {
			{
				"<Leader>r",
				function()
					require("substitute").operator()
				end,
				noremap = true,
				desc = "Substitution operator",
			},
			{
				"<Leader>rr",
				function()
					require("substitute").line()
				end,
				noremap = true,
				desc = "Substitute line with register",
			},
			{
				"<Leader>R",
				function()
					require("substitute").eol()
				end,
				noremap = true,
				desc = "Substitute util eol with register",
			},
		},
	},
	{
		"kwkarlwang/bufjump.nvim",
		dev = true,
		lazy = false,
		config = {
			forward = "<C-i>",
			backward = "<C-o>",
			backwardInBuffer = "<C-p>",
			forwardInBuffer = "<C-l>",
			on_success = nil,
		},
	},
	{
		"vxpm/ferris.nvim",
		opts = {
			create_commands = true,
			url_handler = "xdg-open",
		},
	},
	{
		"davidgranstrom/scnvim",
		lazy = false,
		config = function()
			local scnvim = require("scnvim")
			local map = scnvim.map
			local map_expr = scnvim.map_expr
			scnvim.setup({
				keymaps = {
					["<leader>il"] = map("editor.send_line"),
					["<leader>i<CR>"] = {
						map("editor.send_block"),
						map("editor.send_selection", "x"),
					},
					["<leader>it"] = map("postwin.toggle"),
					["<leader>i<C-t>"] = map("postwin.clear"),
					-- ["<C-k>"] = map("signature.show", { "n", "i" }),
					["<leader>i;"] = map("sclang.hard_stop"),
					["<leader>is"] = map(function()
						scnvim.start()
						scnvim.send("s.boot")
					end),
					-- ["<leader>ik"] = map("sclang.recompile"),
					-- ["<leader>ib"] = map_expr("s.boot"),
					-- ["<F2>"] = map_expr("s.meter"),
				},
				editor = {
					highlight = {
						color = "IncSearch",
					},
				},
				postwin = {
					float = {
						-- enabled = true,
					},
				},
			})
		end,
	},
	{
		"j-hui/fidget.nvim",
		lazy = false,
		opts = {},
	},
}

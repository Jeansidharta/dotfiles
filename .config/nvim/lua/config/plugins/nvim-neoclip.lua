return {
	"AckslD/nvim-neoclip.lua",
	-- dir = "~/projects/personal/vim-plugins/nvim-neoclip.lua",
	event = "BufEnter",
	dependencies = {
		"kkharji/sqlite.lua",
		"nvim-telescope/telescope.nvim",
	},
	config = function()
		require("neoclip").setup({
			enable_persistent_history = true,
			disable_keycodes_parsing = false,
			on_select = {
				move_to_front = true,
			},
			on_paste = {
				move_to_front = true,
				close_telescope = false,
			},
			on_replay = {
				move_to_front = true,
				close_telescope = false,
			},
			continuous_sync = true,
			keys = {
				telescope = {
					i = {
						custom = {
							["<C-DELETE>"] = function()
								require("neoclip").clear_history()
							end,
						},
					},
					n = {
						custom = {
							["<C-DELETE>"] = function()
								require("neoclip").clear_history()
							end,
						},
					},
				},
			},
		})

		require("telescope").load_extension("neoclip")
	end,
	keys = {
		{ "<leader>tc", ":Telescope neoclip<Return>", noremap = true, desc = "Open neoclip in telescope" },
		{
			"<leader>tm",
			":lua require('telescope').extensions.macroscope.default()<Return>",
			noremap = true,
			desc = "Open macroscope in telescope",
		},
	},
}

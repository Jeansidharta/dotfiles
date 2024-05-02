return {
	"lewis6991/hover.nvim",
	commit = "24369e8595736077e30b3ca5fc233f44abeccb8b",
	config = {
		init = function()
			-- Require providers
			require("hover.providers.lsp")
			require("hover.providers.gh")
			require("hover.providers.gh_user")
		end,
		preview_opts = {
			border = nil,
		},
		-- Whether the contents of a currently open hover window should be moved
		-- to a :h preview-window when pressing the hover keymap.
		preview_window = false,
		title = true,
	},

	keys = {
		{
			"K",
			function()
				require("hover").hover()
			end,
			desc = "hover.nvim",
		},
		{
			"<leader>k",
			function()
				require("hover").hover_select()
			end,
			desc = "hover.nvim (select)",
		},
	},
}

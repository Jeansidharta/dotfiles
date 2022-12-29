return {
	"lewis6991/hover.nvim",
	config = {
		init = function()
			-- Require providers
			require("hover.providers.lsp")
			require("hover.providers.gh")
			require("hover.providers.gh_user")
			-- require('hover.providers.jira')
			require("hover.providers.man")
			require("hover.providers.dictionary")
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
			"<leader>k",
			function()
				require("hover").hover()
			end,
			desc = "hover.nvim",
		},
		{
			"<leader>K",
			function()
				require("hover").hover_select()
			end,
			desc = "hover.nvim (select)",
		},
	},
}

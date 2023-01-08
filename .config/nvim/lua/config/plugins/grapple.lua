return {
	"cbochs/grapple.nvim",
	dependencies = { "nvim-lua/plenary.nvim" },
	config = {
		---@type "debug" | "info" | "warn" | "error"
		log_level = "warn",

		---Can be either the name of a builtin scope resolver,
		---or a custom scope resolver
		---@type string | Grapple.ScopeResolver
		scope = "git",

		---Window options used for the popup menu
		popup_options = {
			relative = "editor",
			width = 60,
			height = 12,
			style = "minimal",
			focusable = false,
			border = "single",
		},

		integrations = {
			---Support for saving tag state using resession.nvim
			resession = false,
		},
	},
	keys = {
		{
			"<leader>mm",
			function()
				require("grapple").toggle()
			end,
			noremap = true,
			desc = "Mark grapple",
		},
		{
			"<leader>mt",
			function()
				require("grapple").popup_tags()
			end,
			noremap = true,
			desc = "Open grapple",
		},
	},
}

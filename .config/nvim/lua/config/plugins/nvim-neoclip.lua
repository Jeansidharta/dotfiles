return {
	"AckslD/nvim-neoclip.lua",
	event = "BufEnter",
	dependencies = {
		"kkharji/sqlite.lua",
		"nvim-telescope/telescope.nvim",
	},
	config = function()
		require("neoclip").setup({ continuous_sync = false })

		require("telescope").load_extension("neoclip")
	end,
	keys = {
		{ "<leader>tc", ":Telescope neoclip<Return>", noremap = true },
		{ "<leader>tm", ":lua require('telescope').extensions.macroscope.default()<Return>", noremap = true },
	},
}

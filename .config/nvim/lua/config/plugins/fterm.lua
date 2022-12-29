return {
	"numToStr/FTerm.nvim",
	config = {
		blend = 10,
	},

	keys = {
		{
			"<leader>|t",
			function()
				require("FTerm").toggle()
			end,
			noremap = true,
		},
		{
			"<leader>|t",
			function()
				require("FTerm").toggle()
			end,
			noremap = true,
		},
	},
}

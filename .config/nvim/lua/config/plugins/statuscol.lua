return {
	"luukvbaal/statuscol.nvim",
	lazy = false,
	config = function()
		local builtin = require("statuscol.builtin")
		require("statuscol").setup({
			relculright = true,
			segments = {
				{
					sign = {
						name = { "Diagnostic" },
						maxwidth = 1,
						colwidth = 1,
						fillchar = " ",
						auto = false,
					},
					click = "v:lua.ScSa",
				},
				{
					sign = {
						name = { ".*" },
						maxwidth = 1,
						colwidth = 1,
						auto = true,
						wrap = true,
					},
					click = "v:lua.ScSa",
				},
				{ text = {
					builtin.lnumfunc,
				}, click = "v:lua.ScLa" },
				{ text = {
					builtin.foldfunc,
					auto = true,
				}, click = "v:lua.ScFa", hl = "" },
			},
		})
	end,
}

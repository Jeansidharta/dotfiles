function config()
	require("hop").setup({
		keys = "etovxqpdygfblzhckisuran",
		create_hl_autocmd = false,
	})

	vim.cmd([[highlight link HopPreview Identifier]])
	-- vim.api.nvim_command("autocmd ColorScheme * highlight link HopPreview Identifier")
end

return {
	"phaazon/hop.nvim",
	branch = "v2", -- optional but strongly recommended
	config = config,
	keys = {
		{ "s", ":HopPattern<Return>", noremap = true },
		{ "S", ":HopPatternMW<Return>", noremap = true },
	},
}

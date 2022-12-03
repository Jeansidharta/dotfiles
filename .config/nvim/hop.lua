require("hop").setup({
	keys = "etovxqpdygfblzhckisuran",
	create_hl_autocmd = false,
})

vim.cmd([[highlight link HopPreview Identifier]])

-- vim.api.nvim_command("autocmd ColorScheme * highlight link HopPreview Identifier")

vim.api.nvim_set_keymap("n", "s", ":HopPattern<Return>", { noremap = true })

vim.api.nvim_set_keymap("n", "S", ":HopPatternMW<Return>", { noremap = true })

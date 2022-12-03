vim.api.nvim_set_keymap("n", "<leader>r<Return>", ":SnipRun<Return>", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>rr", ":'<,'>SnipRun<Return>", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>ri", ":SnipInfo<Return>", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>rc", ":SnipReset<Return>", { noremap = true })

require("sniprun").setup({
	inline_messages = 1,
	selected_interpreters = { "Lua_nvim" },
	display = {
		-- "Classic", -- "display results in the command-line  area
		"VirtualTextOk", -- "display ok results as virtual text (multiline is shortened)
		-- "VirtualTextErr", -- "display error results as virtual text
		-- "TempFloatingWindow", -- "display results in a floating window
		-- "LongTempFloatingWindow",  -- "same as above, but only long results. To use with VirtualText__
		-- "Terminal"                 -- "display results in a vertical split
		-- "TerminalWithCode",        --# display results and code history in a vertical split
		"NvimNotify", --# display with the nvim-notify plugin
		-- "Api"                      --# return output to a programming interface
	},
})

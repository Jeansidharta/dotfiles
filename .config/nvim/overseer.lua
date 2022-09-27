require('overseer').setup()

vim.api.nvim_set_keymap(
	"n",
	"<leader>or",
	":OverseerRun<Return>",
	{ noremap = true }
)

vim.api.nvim_set_keymap(
	"n",
	"<leader>ot",
	":OverseerToggle<Return>",
	{ noremap = true }
)

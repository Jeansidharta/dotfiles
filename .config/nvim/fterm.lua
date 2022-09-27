require'FTerm'.setup({
blend = 10
})

vim.api.nvim_set_keymap(
	"n",
	"<leader>|t",
	":lua require('FTerm').toggle()<Return>",
	{ noremap = true }
)

vim.api.nvim_set_keymap(
	"t",
	"<leader>|t",
	"<C-\\><C-n>:lua require('FTerm').toggle()<Return>",
	{ noremap = true }
)

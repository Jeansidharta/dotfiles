require('neoclip').setup({
	continuous_sync = false
})

require('telescope').load_extension('neoclip')

vim.api.nvim_set_keymap(
	"n",
	"<leader>tc",
	":Telescope neoclip<Return>",
	{ noremap = true }
)

vim.api.nvim_set_keymap(
	"n",
	"<leader>tm",
	":lua require('telescope').extensions.macroscope.default()<Return>",
	{ noremap = true }
)

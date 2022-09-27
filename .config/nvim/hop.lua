require'hop'.setup { keys = 'etovxqpdygfblzhckisuran' }

vim.api.nvim_set_keymap(
	"n",
	"s",
	":HopPattern<Return>",
	{ noremap = true }
)

vim.api.nvim_set_keymap(
	"n",
	"S",
	":HopPatternMW<Return>",
	{ noremap = true }
)

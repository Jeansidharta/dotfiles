vim.opt.list = true
vim.opt.listchars = { multispace = ".", eol = "↴", tab = "▹ ", trail = " " }

vim.cmd([[highlight IndentBlanklineIndent1 guifg=#151433 gui=nocombine]])
vim.cmd([[highlight IndentBlanklineIndent2 guifg=#1f1e4d gui=nocombine]])

require("indent_blankline").setup({
	-- for example, context is off by default, use this to turn it on
	show_end_of_line = true,
	char = "▏",
	show_current_context = true,
	show_current_context_start = true,
	show_first_indent_level = false,

	char_highlight_list = {
		"IndentBlanklineIndent1",
		"IndentBlanklineIndent2",
	},
	show_trailing_blankline_indent = false,
})

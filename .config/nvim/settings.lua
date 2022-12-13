------------ Ruler options ----------
vim.o.number = true
vim.o.ruler = true
vim.o.relativenumber = true

------------ Encoding options ----------
vim.o.encoding = "utf-8"
vim.o.fileencodings = "utf-8"
vim.o.bomb = false

------------ Search options ----------
vim.o.hlsearch = true
vim.o.wrapscan = true
vim.o.incsearch = false
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.infercase = true

------------ Render tab characters ----------
--Unnecessary with indent_blankline plugin
--set list
--set listchars=tab:>\

------------ Tab size config ----------
vim.o.tabstop = 4
vim.o.shiftwidth = 4

------------ Line Column line highlighting ----------
vim.o.cursorline = true
vim.o.cursorcolumn = true
vim.cmd([[highlight CursorLine ctermbg=Yellow cterm=bold guibg=#202020]])
vim.cmd([[highlight CursorColumn ctermbg=Yellow cterm=bold guibg=#202020]])

------------ Timeout ----------
vim.o.timeout = false
vim.o.ttimeout = false

------------ Fix splitting ----------
vim.o.splitbelow = true
vim.o.splitright = true
vim.o.signcolumn = "yes"

------------ Misc ----------
--This options makes so inotifywait works with files being edited by vim
vim.o.backupcopy = "yes"
--Makes so the matching parenthesis and brackets don't jump when placed
vim.o.matchtime = 0
vim.o.showmatch = true
--Set true terminal colors
vim.o.termguicolors = true
--Prevent windows from changing sizes when a new window is created
vim.o.equalalways = false
--Makes so some plugins work better
vim.o.updatetime = 300

--For working with the Treesitter plugin
vim.o.foldmethod = "expr"
vim.o.foldexpr = "nvim_treesitter#foldexpr()"

-- vim.api.nvim_set_hl(0, "FoldColumn", { fg = "#FF0000" })

local group = vim.api.nvim_create_augroup("FileTypeTabStopSetter", { clear = true })

vim.api.nvim_create_autocmd("filetype", {
	pattern = { "javascript", "vue", "lua" },
	group = group,
	callback = function()
		vim.bo.tabstop = 2
	end,
})

vim.api.nvim_create_autocmd("filetype", {
	pattern = { "rust", "json", "html" },
	group = group,
	callback = function()
		vim.bo.tabstop = 4
	end,
})

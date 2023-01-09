vim.g.mapleader = " "

------------ Undo file --------------
local undo_dir = vim.fn.stdpath("data") .. "/undofiles"
if vim.fn.isdirectory(undo_dir) == 0 then
	vim.fn.mkdir(undo_dir, "", 448) -- 448 is 700 perm
end
vim.o.undodir = undo_dir
vim.o.undofile = true

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
-- vim.o.cursorline = true
-- vim.o.cursorcolumn = true
-- vim.api.nvim_set_hl(0, "EndOfBuffer", { bold = true, bg = "#202020" })
-- vim.api.nvim_set_hl(0, "CursorColumn", { bold = true, bg = "NONE" })

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

local file_type_tab_stop_setter_group = vim.api.nvim_create_augroup("FileTypeTabStopSetter", { clear = true })

vim.api.nvim_create_autocmd("filetype", {
	pattern = { "javascript", "vue", "lua" },
	group = file_type_tab_stop_setter_group,
	callback = function()
		vim.bo.tabstop = 2
	end,
})

vim.api.nvim_create_autocmd("filetype", {
	pattern = { "rust", "json", "html" },
	group = file_type_tab_stop_setter_group,
	callback = function()
		vim.bo.tabstop = 4
	end,
})

local random_commands_group = vim.api.nvim_create_augroup("RandomCommands", { clear = true })

vim.api.nvim_create_autocmd("filetype", {
	pattern = { "lua" },
	group = random_commands_group,
	callback = function()
		vim.keymap.set("n", "<leader>ff", function()
			vim.cmd([[luafile %]])
		end)
	end,
})

-- Make things transparent :D

local update_opacity_group = vim.api.nvim_create_augroup("UpdateOpacity", { clear = true })

function set_transparent_background()
	vim.cmd([[
			highlight EndOfBuffer guibg=NONE ctermbg=NONE
			highlight SignColumn guibg=NONE ctermbg=NONE
			highlight VertSplit guibg=NONE ctermbg=NONE
			highlight SpecialKey guibg=NONE ctermbg=NONE
			highlight NonText guibg=NONE ctermbg=NONE
			highlight NonText guibg=NONE ctermbg=NONE
			highlight Folded guibg=NONE ctermbg=NONE
			highlight LineNr guibg=NONE ctermbg=NONE
			highlight Normal guibg=NONE ctermbg=NONE
			highlight NormalFloat guibg=NONE ctermbg=NONE
			highlight NormalNC guibg=NONE ctermbg=NONE
	]])
end

vim.api.nvim_create_autocmd({ "ColorScheme" }, {
	group = update_opacity_group,
	callback = set_transparent_background,
})
--
-- vim.api.nvim_create_user_command("CustomNextObject", function(args)
-- 	print(vim.inspect(args))
-- end, { force = true, nargs = 1 })
--
-- vim.cmd([[
-- function! CustomNextObject(arg)
-- 		execute "CustomNextObject" a:arg
-- endfunction
-- ]])
--
-- local function next_object()
-- 	vim.o.opfunc = "CustomNextObject"
-- 	return "g@"
-- end
-- vim.keymap.set({ "n", "v" }, "gt", next_object, { expr = true })

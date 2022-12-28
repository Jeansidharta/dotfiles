-- Bootstrap lazy.nvim if it's not located.
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"--single-branch",
		"https://github.com/folke/lazy.nvim.git",
		lazypath,
	})
end
vim.opt.runtimepath:prepend(lazypath)

function script_path()
	local str = debug.getinfo(2, "S").source:sub(2)
	return str:match("(.*/)")
end

local path = script_path()

function source_config(config_name)
	vim.cmd("source " .. path .. config_name)
end

source_config("settings.lua")
-- Trigger a highlight in the appropriate direction when pressing these keys:
vim.g.qs_highlight_on_keys = { "f", "F", "t", "T" }
source_config("lazy.lua")

vim.g.mapleader = " "

-- colorscheme codedark
vim.cmd([[colorscheme tokyodark]])

vim.keymap.set({ "n" }, "<leader>,", ":source" .. path .. "init.lua<CR>", { noremap = true })
vim.keymap.set({ "n" }, "<leader>.", ":edit" .. path .. "init.lua<CR>", { noremap = true })
vim.keymap.set({ "n" }, "<C-H>", ":nohlsearch<CR>", { noremap = true })

source_config("colorizer.lua")
source_config("telescope.lua")
source_config("treesitter.lua")
source_config("notify.lua")
source_config("lsp.lua")
source_config("lualine.lua")
source_config("gitsigns.lua")
source_config("dressing.lua")
source_config("hop.lua")
source_config("overseer.lua")
source_config("fidget.lua")
source_config("nvim-surround.lua")
source_config("neoclip.lua")
-- source" .. path .. "shade.lua
source_config("range-highlight.lua")
source_config("fterm.lua")
source_config("git-conflict.lua")
source_config("neoscroll.lua")
source_config("marks.lua")
source_config("comment.lua")
source_config("formatter.lua")
source_config("rest.lua")
source_config("duck.lua")
source_config("nvim-cmp.lua")
source_config("hover.lua")
source_config("indent_blankline.lua")
source_config("illuminate.lua")
source_config("sniprun.lua")
source_config("luasnip.lua")
source_config("grapple.lua")

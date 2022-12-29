require("config.settings")
require("config.lazy")

function script_path()
	local str = debug.getinfo(2, "S").source:sub(2)
	return str:match("(.*/)")
end

local path = script_path()

vim.keymap.set({ "n" }, "<leader>,", ":source" .. path .. "init.lua<CR>", { noremap = true })
vim.keymap.set({ "n" }, "<leader>.", ":edit" .. path .. "init.lua<CR>", { noremap = true })
vim.keymap.set({ "n" }, "<C-H>", ":nohlsearch<CR>", { noremap = true, silent = true })

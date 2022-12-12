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

local group = vim.api.nvim_create_augroup("ZKMarkDown", { clear = true })
vim.api.nvim_create_autocmd({ "FileType" }, {
	pattern = "markdown",
	group = group,
	desc = "Attach ZK mappings to markdown",
	callback = function()
		-- Add the key mappings only for Markdown files in a zk notebook.
		if require("zk.util").notebook_root(vim.fn.expand("%:p")) == nil then
			return
		end

		local function map(...)
			vim.api.nvim_buf_set_keymap(0, ...)
		end
		local opts = { noremap = true, silent = false }

		-- Open the link under the caret.
		map("n", "<CR>", "<Cmd>lua vim.lsp.buf.definition()<CR>", opts)

		map("v", "<leader>/n", ":'<,'>ZkNewFromTitleSelection<CR>", opts)

		-- Open notes linking to the current buffer.
		map("n", "<leader>/b", "<Cmd>ZkBacklinks<CR>", opts)
		-- Alternative for backlinks using pure LSP and showing the source context.
		map("n", "<leader>zb", "<Cmd>lua vim.lsp.buf.references()<CR>", opts)
		-- Open notes linked by the current buffer.
		map("n", "<leader>/l", "<Cmd>ZkLinks<CR>", opts)

		-- Preview a linked note.
		map("n", "K", "<Cmd>lua vim.lsp.buf.hover()<CR>", opts)
		-- Open the code actions for a visual selection.
		map("v", "<leader>a", ":'<,'>lua vim.lsp.buf.range_code_action()<CR>", opts)
		vim.wo.colorcolumn = "81"
		vim.wo.conceallevel = 3
		vim.api.nvim_set_hl(0, "CustomMarkdownLink", { link = "markdownLinkText" })
	end,
})

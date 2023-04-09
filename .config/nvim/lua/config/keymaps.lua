vim.keymap.set("n", "<leader>l", ":messages<CR>", { noremap = true, desc = "Show messages" })
vim.keymap.set("n", "<leader>n", function()
	require("notify").dismiss({})
end, { noremap = true, desc = "Clear all notifications" })

vim.keymap.set("n", "<leader>s<Down>", ":split<CR>", { noremap = true, desc = "Split down" })
vim.keymap.set("n", "<leader>s<Up>", ":split<CR><c-w>k<CR>", { noremap = true, desc = "Split up" })
vim.keymap.set("n", "<leader>s<Left>", ":vsplit<CR><c-w>h<CR>", { noremap = true, desc = "Split left" })
vim.keymap.set("n", "<leader>s<Right>", ":vsplit<CR>", { noremap = true, desc = "Split right" })

------------------ DIAGNOSTICS --------------------
vim.keymap.set("n", "<leader>dn", vim.diagnostic.goto_next, { noremap = true, desc = "Go to next diagnostics" })
vim.keymap.set("n", "<leader>dN", vim.diagnostic.goto_prev, { noremap = true, desc = "Go to prev diagnostics" })
vim.keymap.set("n", "<leader>do", vim.diagnostic.open_float, { noremap = true, desc = "Open diagnostics float" })
vim.keymap.set("n", "<leader>dq", vim.diagnostic.setloclist, { noremap = true, desc = "Open diagnostics float" })

-------------- QUICK FIX --------------------------
vim.keymap.set("n", "<leader>qt", function()
	local qf_exists = false
	for _, win in pairs(vim.fn.getwininfo()) do
		if win["quickfix"] == 1 then
			qf_exists = true
		end
	end
	if qf_exists == true then
		vim.cmd("cclose")
		return
	elseif vim.tbl_isempty(vim.fn.getqflist()) then
		vim.notify("Quick fix list is empty", vim.log.levels.WARN)
	else
		vim.cmd("copen")
	end
end, { noremap = true })

vim.keymap.set("n", "<leader>qn", ":cnext<CR>", { noremap = true })
vim.keymap.set("n", "<leader>qN", ":cprev<CR>", { noremap = true })
vim.keymap.set("n", "<leader>qf", ":cfirst<CR>", { noremap = true })
vim.keymap.set("n", "<leader>ql", ":clast<CR>", { noremap = true })
vim.keymap.set("n", "<leader>qc", ":cexpr []<CR>", { noremap = true })

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
		--map('n', '<leader>zb', '<Cmd>lua vim.lsp.buf.references()<CR>', opts)
		-- Open notes linked by the current buffer.
		map("n", "<leader>/l", "<Cmd>ZkLinks<CR>", opts)

		-- Preview a linked note.
		map("n", "K", "<Cmd>lua vim.lsp.buf.hover()<CR>", opts)
		-- Open the code actions for a visual selection.
		map("v", "<leader>a", ":'<,'>lua vim.lsp.buf.range_code_action()<CR>", opts)
		vim.wo.colorcolumn = "81"
		vim.wo.conceallevel = 3
		vim.cmd(
			[[:syntax region CustomMarkdownLink concealends contained matchgroup=markdownUrl start="\[" end="](.\+)"]]
		)
		vim.cmd([[:syntax match CustomPossibleMarkdownLink contains=CustomMarkdownLink "\[.\+](.\+)"]])
		vim.api.nvim_set_hl(0, "CustomMarkdownLink", { link = "markdownLinkText" })

		vim.keymap.set({ "v" }, "<leader>/i", function()
			require("zk").pick_notes({}, {}, function(notes)
				local note = notes[1]
				vim.cmd('noautocmd normal! "vy"')
				vim.pretty_print(vim.fn.getreg("v"))
				-- local start_pos = vim.api.nvim_buf_get_mark(0, "<")
				-- local end_pos = vim.api.nvim_buf_get_mark(0, ">")
				-- vim.pretty_print(start_pos, end_pos)
			end)
		end)

		vim.keymap.set({ "n" }, "<leader>/i", function()
			require("zk").pick_notes({}, {}, function(notes)
				local note = notes[1]
				vim.fn.setreg('""', note.path, "c")
				vim.cmd([[:normal p]])
			end)
		end)
	end,
})

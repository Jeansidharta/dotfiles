vim.keymap.set("n", "<Tab>", ":w<CR>", { noremap = true, desc = "Save buffer" })
vim.keymap.set("n", "<leader>l", ":messages<CR>", { noremap = true, desc = "Show messages" })
vim.keymap.set("n", "<leader>n", function()
	require("notify").dismiss({})
end, { noremap = true, desc = "Clear all notifications" })

vim.keymap.set("n", "<leader>s<Down>", ":split<CR>", { noremap = true, desc = "Split down" })
vim.keymap.set("n", "<leader>s<Up>", ":split<CR><c-w>k<CR>", { noremap = true, desc = "Split up" })
vim.keymap.set("n", "<leader>s<Left>", ":vsplit<CR><c-w>h<CR>", { noremap = true, desc = "Split left" })
vim.keymap.set("n", "<leader>s<Right>", ":vsplit<CR>", { noremap = true, desc = "Split right" })

vim.keymap.set("n", "<C-p>", "<C-o>", { noremap = true, desc = "Jump back in jumplist" })


-- vim.keymap.set("n", "p", "<Plug>(NeoclipYankForward)", { noremap = true, desc = "" })

vim.keymap.set(
	"n",
	"za",
	":try \n :%g/^\\w/ .folddoopen foldclose \n :endtry<CR>:nohlsearch<CR>",
	{ noremap = true, desc = "Close top-level fold" }
)

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
end, { noremap = true, desc = "Toggle Quick Fix" })

vim.keymap.set("n", "<leader>qo", ":copen<CR>", { noremap = true, desc = "Open Quick Fix" })
vim.keymap.set("n", "<leader>qn", ":cnext<CR>", { noremap = true, desc = "Next Quick Fix" })
vim.keymap.set("n", "<leader>qN", ":cprev<CR>", { noremap = true, desc = "Prev Quick Fix" })
vim.keymap.set("n", "<leader>qf", ":cfirst<CR>", { noremap = true, desc = "First item in Quick Fix" })
vim.keymap.set("n", "<leader>ql", ":clast<CR>", { noremap = true, desc = "Last item in Quick Fix" })
vim.keymap.set("n", "<S-Tab>", ":lua vim.lsp.buf.format()<CR>", { noremap = true, desc = "Format buffer" })

----------------- LSP -------------------

local bufopts = function(desc)
	return { noremap = true, silent = true, buffer = bufnr, desc = desc }
end
vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts("Go to declaration"))
vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts("Go to definition"))
vim.keymap.set("n", "gt", vim.lsp.buf.type_definition, bufopts("Go to type definition"))
vim.keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts("Go to implementation"))
vim.keymap.set("n", "gr", vim.lsp.buf.references, bufopts("Go to references"))
vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, bufopts("Signature help"))
vim.keymap.set("n", "<space>a", vim.lsp.buf.code_action, bufopts("Code action"))
vim.keymap.set("n", "<space>wl", function()
	print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
end, bufopts("List workspace folders"))
vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, bufopts("Rename symbol"))

----------------- OTHER -------------------

vim.keymap.set("n", "<leader>io", function()
	vim.ui.select({ "markdown" }, { prompt = "Select new file type" }, function(choice)
		vim.cmd(vim.api.nvim_replace_termcodes('normal! :vnew<CR>:set filetype=' .. choice .. '<CR>', true, true, true))
	end)
end, { noremap = true, desc = "New file selector" })
vim.keymap.set("n", "++", "\"zyymzo```<ESC>'z==O```<ESC>P", { noremap = true, desc = "Run current line" })
vim.keymap.set("n", "<leader>df", function()
	local function get_closest_diagnostic()
		local next = vim.diagnostic.get_next()
		local prev = vim.diagnostic.get_prev()

		if next == nil and prev == nil then
			return nil
		elseif next == nil then
			return prev
		elseif prev ==
			nil then
			return next
		end

		local curr_buffer = vim.api.nvim_get_current_buf()

		if curr_buffer ~= next.buffer and curr_buffer ~= prev.buffer then
			return next
		elseif curr_buffer ~= next.buffer then
			return prev
		elseif curr_buffer ~= prev.buffer then
			return next
		end

		local curpos = vim.fn.getcurpos()
		local curline = curpos[2]
		local curcol = curpos[3]

		if curline ~= next.lnum and curline == prev.lnum then
			return prev
		elseif curline == next.lnum and curline ~= prev.lnum then
			return
				next
		elseif curline == next.lnum and curline == prev.lnum then
			if math.abs(curcol - next.col) < math.abs(curcol - prev.col) then
				return next
			else
				return prev
			end
		else
			if math.abs(curline - next.lnum) < math.abs(curline - prev.lnum) then
				return next
			else
				return prev
			end
		end
	end

	local closest_diagnostic = get_closest_diagnostic()
	if closest_diagnostic == nil then
		vim.notify("No diagnostics available")
	else
		require('config.utils').open_editor_temp_window(vim.split(closest_diagnostic.message, "\n"), "text")
	end
end, { noremap = true, desc = "Run current line" })

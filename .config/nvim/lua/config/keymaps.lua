vim.keymap.set("n", "<leader>l", ":messages<CR>", { noremap = true })

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

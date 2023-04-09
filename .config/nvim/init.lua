require("config.settings")
require("config.lazy")
require("config.keymaps")

local function script_path()
	local str = debug.getinfo(2, "S").source:sub(2)
	return str:match("(.*/)")
end

local path = script_path()

vim.keymap.set({ "n" }, "<leader>,", ":source" .. path .. "init.lua<CR>", { noremap = true })
vim.keymap.set({ "n" }, "<leader>.", ":edit" .. path .. "/lua/config/plugins/init.lua<CR>", { noremap = true })
vim.keymap.set({ "n" }, "<C-H>", ":nohlsearch<CR>", { noremap = true, silent = true })

vim.filetype.add({ extension = { lol = "lolcode" } })

local group = vim.api.nvim_create_augroup("lolcode-lsp", { clear = true })

vim.api.nvim_create_autocmd({ "FileType" }, {
	group = group,
	pattern = "lolcode",
	callback = function(args)
		local buf = args.buf
		local exec_path = "/home/sidharta/projects/personal/lolcode-lsp/target/debug/lolcode-lsp"
		local capabilities = vim.lsp.protocol.make_client_capabilities()
		capabilities.textDocument.hover.dynamicRegistration = true
		local client = vim.lsp.start_client({
			cmd = { exec_path, "run" },
			name = "lolcode-lsp",
			capabilities = capabilities,
			root_dir = "/home/sidharta",
			on_init = function(client, initialize_results)
				vim.pretty_print(client)
			end,
			handlers = {
				["textDocument/hover"] = function()
					print("Hover!!")
				end,
				["textDocument/codeAction"] = function()
					print("CODE ACTIONNNN")
				end,
			},
		})

		vim.lsp.buf_attach_client(buf, client)
	end,
})

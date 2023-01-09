function config()
	-- Mappings.
	-- See `:help vim.diagnostic.*` for documentation on any of the below functions

	local capabilities = require("cmp_nvim_lsp").default_capabilities()

	-- Use an on_attach function to only map the following keys
	-- after the language server attaches to the current buffer
	local on_attach = function(client, bufnr)
		-- Enable completion triggered by <c-x><c-o>
		vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

		-- Mappings.
		-- See `:help vim.lsp.*` for documentation on any of the below functions
		local bufopts = function(desc)
			return { noremap = true, silent = true, buffer = bufnr, desc = desc }
		end
		vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts("Go to declaration"))
		vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts("Go to definition"))
		vim.keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts("Go to implementation"))
		vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, bufopts("Signature help"))
		vim.keymap.set("n", "<space>wa", vim.lsp.buf.add_workspace_folder, bufopts("Add workspace folder"))
		vim.keymap.set("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, bufopts("Remove workspace folder"))
		vim.keymap.set("n", "<space>wl", function()
			print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
		end, bufopts("List workspace folders"))
		vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition, bufopts("Go to type definition"))
		vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, bufopts("Rename symbol"))
		vim.keymap.set("n", "<space>ca", vim.lsp.buf.code_action, bufopts("Code action"))
		vim.keymap.set("n", "gr", vim.lsp.buf.references, bufopts("Go to references"))
		vim.keymap.set("n", "<space>f", function()
			return vim.lsp.buf.formatting({ async = true })
		end, bufopts("Formating"))
	end

	local lsp_flags = {
		-- This is the default in Nvim 0.7+
		debounce_text_changes = 150,
	}

	-- local packages = require("mason-registry").get_installed_packages()

	require("lspconfig")["fennel-ls"].setup({})
	require("mason-lspconfig").setup_handlers({
		function(server_name) -- default handler (optional)
			require("lspconfig")[server_name].setup({
				on_attach = on_attach,
				flags = lsp_flags,
				capabilities = capabilities,
			})
		end,

		["sumneko_lua"] = function(_)
			-- This will be the path towards your sumneko folder. This is subjective
			local mason_path = require("mason.settings").current.install_root_dir
			local sumneko_binary = mason_path .. "/bin/lua-language-server"
			local sumneko_main = mason_path .. "/packages/lua-language-server/extension/server/main.lua"

			require("lspconfig").sumneko_lua.setup({
				cmd = { sumneko_binary, sumneko_main },
				on_attach = on_attach,
				flags = lsp_flags,
				capabilities = capabilities,
				settings = {
					Lua = {
						runtime = { version = "LuaJIT", path = vim.split(package.path, ";") },
						completion = { enable = true, callSnippet = "Both" },
						diagnostics = {
							enable = true,
							globals = { "vim", "describe" },
							disable = { "lowercase-global" },
						},
						workspace = {
							library = {
								[vim.fn.expand("$VIMRUNTIME/lua")] = true,
								[vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
								[vim.fn.expand("/usr/share/awesome/lib")] = true,
							},
							-- adjust these two values if your performance is not optimal
							maxPreload = 2000,
							thirdParty = false,
							preloadFileSize = 1000,
						},
					},
				},
			})
		end,
	})
end

return {
	"neovim/nvim-lspconfig",
	lazy = false,
	config = config,
	dependencies = {
		{ "folke/neodev.nvim", config = {
			override = function()
				return true
			end,
		} },
		{ "williamboman/mason.nvim", config = true, dir = "~/git/mason.nvim" },
		{
			"williamboman/mason-lspconfig.nvim",
			config = {
				ensure_installed = { "sumneko_lua", "rust_analyzer" },
			},
		},
	},
}
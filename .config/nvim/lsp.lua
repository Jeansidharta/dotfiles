local coq = require("coq")
local lsp_format = require("lsp-format")

-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap = true, silent = true }
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
	-- Enable completion triggered by <c-x><c-o>
	vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
	-- Force vuels to be able to format
	if client.name == "vuels" then
		client.resolved_capabilities.document_formatting = true
		print(vim.inspect(client))
	end
	lsp_format.on_attach(client)

	-- Mappings.
	-- See `:help vim.lsp.*` for documentation on any of the below functions
	local bufopts = { noremap = true, silent = true, buffer = bufnr }
	vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
	vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
	vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
	vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
	vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
	vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
	vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
	vim.keymap.set('n', '<space>wl', function()
		print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
	end, bufopts)
	vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
	vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
	vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
	vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
	vim.keymap.set('n', '<space>f', vim.lsp.buf.formatting, bufopts)
end

local lsp_flags = {
	-- This is the default in Nvim 0.7+
	debounce_text_changes = 150,
}
require('lspconfig')['pyright'].setup(coq.lsp_ensure_capabilities({
	on_attach = on_attach,
	flags = lsp_flags,
}))
require('lspconfig')['tsserver'].setup(coq.lsp_ensure_capabilities({
	on_attach = on_attach,
	flags = lsp_flags,
}))
require('lspconfig')['rust_analyzer'].setup(coq.lsp_ensure_capabilities({
	on_attach = on_attach,
	flags = lsp_flags,
	-- Server-specific settings...
	settings = {
		["rust-analyzer"] = {}
	}
}))

require('lspconfig').vuels.setup(coq.lsp_ensure_capabilities({
	on_attach = on_attach,
	flags = lsp_flags,
	config = {
		vetur = {
			format = {
				enabled = true,
				defaultFormatter = {
					html = "prettier",
					pug = "prettier",
					css = "prettier",
					postcss = "prettier",
					scss = "prettier",
					less = "prettier",
					stylus = "prettier",
					js = "prettier",
					ts = "prettier",
					sass = "prettier"
				},
			}
		}
	}
}))

-- This will be the path towards your sumneko folder. This is subjective
local sumneko_root_path = os.getenv("HOME") .. "/programs/lua-language-server"
local sumneko_binary = sumneko_root_path .. "/bin/lua-language-server"
require 'lspconfig'.sumneko_lua.setup(coq.lsp_ensure_capabilities({
	cmd = { sumneko_binary, "-E", sumneko_root_path .. "/main.lua" },
	on_attach = on_attach,
	flags = lsp_flags,
	settings = {
		Lua = {
			runtime = { version = 'LuaJIT', path = vim.split(package.path, ';') },
			completion = { enable = true, callSnippet = "Both" },
			diagnostics = {
				enable = true,
				globals = { 'vim', 'describe' },
				disable = { "lowercase-global" }
			},
			workspace = {
				library = {
					[vim.fn.expand('$VIMRUNTIME/lua')] = true,
					[vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true,
					[vim.fn.expand('/usr/share/awesome/lib')] = true
				},
				-- adjust these two values if your performance is not optimal
				maxPreload = 2000,
				preloadFileSize = 1000
			}
		}
	},
}))

require 'lspconfig'.bashls.setup(coq.lsp_ensure_capabilities({ on_attach = on_attach, flags = lsp_flags }))
require 'lspconfig'.cssls.setup(coq.lsp_ensure_capabilities({ on_attach = on_attach, flags = lsp_flags }))
require 'lspconfig'.html.setup(coq.lsp_ensure_capabilities({ on_attach = on_attach, flags = lsp_flags }))
require 'lspconfig'.jsonls.setup(coq.lsp_ensure_capabilities({ on_attach = on_attach, flags = lsp_flags }))
require 'lspconfig'.terraformls.setup(coq.lsp_ensure_capabilities({ on_attach = on_attach, flags = lsp_flags }))
require 'lspconfig'.vimls.setup(coq.lsp_ensure_capabilities({ on_attach = on_attach, flags = lsp_flags }))
require 'lspconfig'.zls.setup(coq.lsp_ensure_capabilities({ on_attach = on_attach, flags = lsp_flags }))
require 'lspconfig'.gopls.setup(coq.lsp_ensure_capabilities({ on_attach = on_attach, flags = lsp_flags }))

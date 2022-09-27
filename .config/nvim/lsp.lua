local coq = require("coq")

-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap=true, silent=true }
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(_, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local bufopts = { noremap=true, silent=true, buffer=bufnr }
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
  -- vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
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

require'lspconfig'.vuels.setup(coq.lsp_ensure_capabilities({}))

-- This will be the path towards your sumneko folder. This is subjective
local sumneko_root_path = os.getenv("HOME") .. "/programs/lua-language-server"
local sumneko_binary = sumneko_root_path .. "/bin/lua-language-server"
require'lspconfig'.sumneko_lua.setup(coq.lsp_ensure_capabilities({
	cmd = {sumneko_binary, "-E", sumneko_root_path .. "/main.lua"},
	settings = {
		Lua = {
			runtime = {version = 'LuaJIT', path = vim.split(package.path, ';')},
			completion = {enable = true, callSnippet = "Both"},
			diagnostics = {
				enable = true,
				globals = {'vim', 'describe'},
				disable = {"lowercase-global"}
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

require'lspconfig'.bashls.setup(coq.lsp_ensure_capabilities({}))
require'lspconfig'.cssls.setup(coq.lsp_ensure_capabilities({}))
require'lspconfig'.html.setup(coq.lsp_ensure_capabilities({}))
require'lspconfig'.jsonls.setup(coq.lsp_ensure_capabilities({}))
require'lspconfig'.terraformls.setup(coq.lsp_ensure_capabilities({}))
require'lspconfig'.vimls.setup(coq.lsp_ensure_capabilities({}))
require'lspconfig'.zls.setup(coq.lsp_ensure_capabilities({}))
require'lspconfig'.gopls.setup(coq.lsp_ensure_capabilities({}))

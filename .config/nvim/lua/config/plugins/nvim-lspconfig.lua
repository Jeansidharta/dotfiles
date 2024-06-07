vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("UserLspConfig", {}),
	callback = function(ev)
		local bufnr = ev.buf
		local client = vim.lsp.get_client_by_id(ev.data.client_id)
		if not client then
			return
		end
		if client.server_capabilities.inlayHintProvider then
			vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
		end
	end,
})

local function config()
	local capabilities = require("cmp_nvim_lsp").default_capabilities()

	-- Use an on_attach function to only map the following keys
	-- after the language server attaches to the current buffer
	local on_attach = function(client, bufnr) end

	require("mason-lspconfig").setup_handlers({
		function(server_name) -- default handler (optional)
			require("lspconfig")[server_name].setup({
				on_attach = on_attach,
				flags = {},
				capabilities = capabilities,
			})
		end,

		["rust_analyzer"] = function() end,
		["tsserver"] = function()
			require("lspconfig").tsserver.setup({
				init_options = {
					preferences = {
						interactiveInlayHints = true,
						includeInlayParameterNameHints = "all",
						includeInlayParameterNameHintsWhenArgumentMatchesName = true,
						includeInlayFunctionParameterTypeHints = true,
						includeInlayVariableTypeHints = true,
						includeInlayPropertyDeclarationTypeHints = true,
						includeInlayFunctionLikeReturnTypeHints = true,
						includeInlayEnumMemberValueHints = true,
						importModuleSpecifierPreference = "non-relative",
					},
				},
			})
		end,
	})

	require("lspconfig").gleam.setup({})

	require("lspconfig").openscad_ls.setup({
		cmd = {
			"/home/sidharta/projects/git/openscad-LSP/target/release/openscad-lsp",
			"--stdio",
			"--fmt-exe",
			"asdfg",
		},
	})
end

return {
	"neovim/nvim-lspconfig",
	lazy = false,
	config = config,
	dependencies = {
		{ "williamboman/mason.nvim", config = true },
		{
			"williamboman/mason-lspconfig.nvim",
			config = {},
		},
	},
}

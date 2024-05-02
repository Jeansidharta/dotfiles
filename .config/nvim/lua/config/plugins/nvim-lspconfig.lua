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

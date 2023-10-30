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
		["efm"] = function()
			require("lspconfig")["efm"].setup({
				init_options = {
					documentFormatting = true,
					documentRangeFormatting = true,
				},
				capabilities,
				settings = {
					rootMarkers = { ".git/" },
					languages = {
						markdown = {
							vim.tbl_extend("force", require("efmls-configs.formatters.prettier_d"),
								{ requireMarker = false }),
						},
						json = {
							vim.tbl_extend("force", require("efmls-configs.linters.jq"), { requireMarker = false }),
						},
					},
				},
				filetypes = { "markdown", "json" },
				single_file_support = true,
			})
		end,
	})
end

return {
	"neovim/nvim-lspconfig",
	lazy = false,
	config = config,
	dependencies = {
		{ "creativenull/efmls-configs-nvim" },
		-- {
		-- 	"folke/neodev.nvim",
		-- 	config = {
		-- 		override = function()
		-- 			return true
		-- 		end,
		-- 	}
		-- },
		{ "williamboman/mason.nvim",        config = true },
		{
			"williamboman/mason-lspconfig.nvim",
			config = {
				-- ensure_installed = { "lua_ls", "rust_analyzer" },
			},
		},
	},
}

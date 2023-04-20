return {
	"jose-elias-alvarez/null-ls.nvim",
	dependencies = {
		"jose-elias-alvarez/null-ls.nvim",
		"lewis6991/gitsigns.nvim",

		{ "lukas-reineke/lsp-format.nvim", config = true },
	},
	config = function()
		local nls = require("null-ls")
		nls.setup({
			debounce = 150,
			-- save_after_format = false,
			on_attach = function(client)
				require("lsp-format").on_attach(client)
			end,
			should_attach = function(bufnr)
				local filetype = vim.api.nvim_buf_get_option(bufnr, "filetype")
				return filetype ~= "text-image"
			end,
			sources = {
				nls.builtins.code_actions.gitsigns,
				-- Lua
				nls.builtins.formatting.stylua,
				nls.builtins.diagnostics.selene.with({
					condition = function(utils)
						return utils.root_has_file({ "selene.toml" })
					end,
				}),
				-- Others
				nls.builtins.formatting.prettierd.with({
					env = {
						PRETTIERD_DEFAULT_CONFIG = "/home/sidharta/.config/prettier/.prettierrc.json",
					},
					filetypes = {
						"javascript",
						"javascriptreact",
						"typescript",
						"typescriptreact",
						"vue",
						"css",
						"svelte",
						"scss",
						"less",
						"html",
						"json",
						"jsonc",
						"yaml",
						"markdown",
						"markdown.mdx",
						"graphql",
						"handlebars",
						"astro",
					},
				}),
				nls.builtins.formatting.rustfmt,
				nls.builtins.formatting.terraform_fmt,
			},
			root_dir = require("null-ls.utils").root_pattern(".null-ls-root", ".git"),
		})
	end,
	lazy = false,
}

return {
	"jose-elias-alvarez/null-ls.nvim",
	dependencies = { "jose-elias-alvarez/null-ls.nvim", "lewis6991/gitsigns.nvim",

		{ "lukas-reineke/lsp-format.nvim", config = true },
		},
	config = function()
		local nls = require("null-ls")
		nls.setup({
			debounce = 150,
			-- save_after_format = false,
			on_attach = function(client)
        require('lsp-format').on_attach(client)
			end,
			sources = {
				-- Lua
				nls.builtins.formatting.stylua,
				nls.builtins.diagnostics.editorconfig_checker,
				nls.builtins.code_actions.gitsigns,
				nls.builtins.diagnostics.selene.with({
					condition = function(utils)
						return utils.root_has_file({ "selene.toml" })
					end,
				}),
				-- Others
				nls.builtins.formatting.prettierd,
				nls.builtins.formatting.rustfmt,
				nls.builtins.formatting.terraform_fmt,
			},
			root_dir = require("null-ls.utils").root_pattern(".null-ls-root", ".git"),
		})
	end,
	lazy = false,
}

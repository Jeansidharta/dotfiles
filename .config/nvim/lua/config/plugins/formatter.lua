function config()
	-- Provides the Format, FormatWrite, FormatLock, and FormatWriteLock commands
	require("formatter").setup({
		-- Enable or disable logging
		logging = true,
		-- Set the log level
		log_level = vim.log.levels.WARN,
		-- All formatter configurations are opt-in
		filetype = {
			-- Formatter configurations for filetype "lua" go here
			-- and will be executed in order
			lua = {
				-- "formatter.filetypes.lua" defines default configurations for the
				-- "lua" filetype
				require("formatter.filetypes.lua").stylua,
			},

			typescript = { require("formatter.filetypes.typescript").prettier },
			javascript = { require("formatter.filetypes.javascript").prettier },

			-- Requires the prettier-plugin-nginx plugin. Link here:
			-- https://github.com/joedeandev/prettier-plugin-nginx
			nginx = { require("formatter.defaults.prettier") },
			html = { require("formatter.filetypes.html").prettier },
			rust = { require("formatter.filetypes.rust").rustfmt },
			markdown = { require("formatter.filetypes.markdown").prettier },
			vue = { require("formatter.defaults.prettier") },
			terraform = {
				{
					exe = "terraform",
					args = {
						"fmt",
						"-",
					},
					stdin = true,
				},
			},

			-- Use the special "*" filetype for defining formatter configurations on
			-- any filetype
			["*"] = {
				-- "formatter.filetypes.any" defines default configurations for any
				-- filetype
				require("formatter.filetypes.any").remove_trailing_whitespace,
			},
		},
	})

	local group = vim.api.nvim_create_augroup("FormatOnSave", { clear = true })

	function create_autocmd()
		vim.api.nvim_create_autocmd({ "BufWritePost" }, {
			group = group,
			pattern = { "*.ts", "*.js", "*.html", "*.md", "*.vue", "*.rs", "*.lua", "*.tf", "*.nginx" },
			command = "FormatWrite",
		})
	end

	create_autocmd()
	vim.api.nvim_create_user_command("FormatDisable", function()
		group = vim.api.nvim_create_augroup("FormatOnSave", { clear = true })
	end, { force = true })

	vim.api.nvim_create_user_command("FormatEnable", function()
		group = vim.api.nvim_create_augroup("FormatOnSave", { clear = true })
		create_autocmd()
	end, { force = true })

	-- This is a POC for enabling auto-formating on specific filetypes, not file extensions
	--
	-- vim.api.nvim_create_autocmd({ "FileType" }, {
	-- 	pattern = { "typescript", "javascript", "html", "markdown", "vue", "rust", "lua", "terraform", "nginx" },
	-- 	callback = function()
	-- 		vim.api.nvim_create_autocmd({ "BufWritePost" }, {
	-- 			command = "FormatWrite",
	-- 		})
	-- 	end,
	-- })
end

return {
	"mhartington/formatter.nvim",
	config = config,
	event = "BufEnter",
}

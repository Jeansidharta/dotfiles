return {
	"jubnzv/mdeval.nvim",
	dev = true,
	keys = {
		{ "<leader>ii" }
	},
	config = function()
		local mdeval = require('mdeval')
		vim.keymap.set("n", "<leader>ii", function()
				mdeval.eval_code_block()
			end,
			{ noremap = true, desc = "Evaluate code block" })
		mdeval.setup({
			allowed_file_types = { 'usql' },
			-- Don't ask before executing code blocks
			require_confirmation = false,
			-- Change code blocks evaluation options.
			eval_options = {
				curl_post = {
					command = { "curl", "--silent", "--request", "POST", "--header", "\"Content-Type: application/json\"", "$$", "--data" },
					exec_type = 'argument',
					language_code = 'curl_post',
				},
				curl = {
					command = { "curl", "--silent" },
					exec_type = 'argument',
					language_code = 'curl',
				},
				usql = {
					command = { "usql", "$$", "-q", "-f" },
					exec_type = 'interpreted',
					language_code = 'usql',
				},
			},
		})
	end
}

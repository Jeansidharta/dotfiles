--- @param initial_lines string[]
function create_editor_window(initial_lines, callback)
	local edit_buffer = vim.api.nvim_create_buf(false, true)
	vim.api.nvim_buf_set_lines(edit_buffer, 0, -1, false, initial_lines)

	function get_ideal_config()
		local stats = vim.api.nvim_list_uis()[1]
		local width = stats.width
		local height = stats.height
		local winWidth = math.ceil(width * 0.8)
		local winHeight = math.ceil(height * 0.8)
		return {
			relative = "editor",
			style = "minimal",
			border = "double",
			width = winWidth,
			height = winHeight,
			col = math.ceil((width - winWidth) / 2),
			row = math.ceil((height - winHeight) / 2) - 1,
		}
	end

	local win = vim.api.nvim_open_win(edit_buffer, true, get_ideal_config())
	vim.api.nvim_create_autocmd("VimResized", {
		buffer = edit_buffer,
		callback = function()
			vim.api.nvim_win_set_config(win, get_ideal_config())
		end,
	})
	vim.api.nvim_create_autocmd("WinClosed", {
		buffer = edit_buffer,
		callback = function()
			local new_value = vim.api.nvim_buf_get_lines(edit_buffer, 0, -1, false)
			vim.api.nvim_buf_delete(edit_buffer, { force = true })
			callback(new_value)
		end,
	})
end

function replace_macro(opts)
	local storage = require("neoclip.storage")
	create_editor_window(opts.entry.contents, function(new_macro_content)
		local new_entry = vim.deepcopy(opts.entry)
		new_entry.contents = new_macro_content
		storage.replace(opts.typ, opts.entry, new_entry)
	end)
end

function handle_replace_action(opts)
	replace_macro(opts)
end

return {
	-- "AckslD/nvim-neoclip.lua",
	dir = "~/projects/personal/vim-plugins/nvim-neoclip.lua",
	event = "BufEnter",
	dependencies = {
		"kkharji/sqlite.lua",
		"nvim-telescope/telescope.nvim",
	},
	config = function()
		require("neoclip").setup({
			enable_persistent_history = true,
			on_select = {
				move_to_front = true,
			},
			on_paste = {
				-- move_to_front = true,
			},
			on_replay = {
				-- move_to_front = true,
			},
			continuous_sync = true,
			keys = {
				telescope = {
					i = {
						custom = {
							["<c-e>"] = handle_replace_action,
						},
					},
					n = {
						custom = {
							["e"] = handle_replace_action,
						},
					},
				},
			},
		})

		require("telescope").load_extension("neoclip")
	end,
	keys = {
		{ "<leader>tc", ":Telescope neoclip<Return>", noremap = true, desc = "Open neoclip in telescope" },
		{
			"<leader>tm",
			":lua require('telescope').extensions.macroscope.default()<Return>",
			noremap = true,
			desc = "Open macroscope in telescope",
		},
	},
}

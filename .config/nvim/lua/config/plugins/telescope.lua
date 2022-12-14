function config()
	local actions = require("telescope.actions")
	local action_state = require("telescope.actions.state")

	function reset_selected_files(prompt_bufnr)
		local selections = action_state.get_current_picker(prompt_bufnr):get_multi_selection()

		if #selections == 0 then
			return vim.notify("No files selected to be reset", "Error")
		end

		local message = ""
		for _, selection in pairs(selections) do
			local command
			local path = selection.path
			if selection.status == "??" then -- File is untracked
				command = "git clean -f " .. path .. " 2>&1"
				message = message .. "Removing " .. selection.value .. "\n"
			else
				command = "git restore --staged --worktree " .. path .. " 2>&1"
				message = message .. "Restoring " .. selection.value .. "\n"
			end
			local handler = io.popen(command)
			handler:read("*a")
		end
		vim.notify(message)
		actions.close(prompt_bufnr)
	end

	function pull_selected_branches(prompt_bufnr)
		local branch_name = action_state.get_selected_entry(prompt_bufnr).name
		io.popen("git pull origin " .. branch_name .. " 2>&1")
	end

	require("telescope").setup({
		defaults = {
			mappings = {
				--n = {
				--}
			},
		},
		pickers = {
			git_commits = {
				mappings = {
					i = {
						["<C-z>"] = actions.cycle_previewers_next,
						["<C-x>"] = actions.cycle_previewers_prev,
					},
					n = {
						["z"] = actions.cycle_previewers_next,
						["x"] = actions.cycle_previewers_prev,
					},
				},
			},
			git_bcommits = {
				mappings = {
					i = {
						["<C-z>"] = actions.cycle_previewers_next,
						["<C-x>"] = actions.cycle_previewers_prev,
					},
					n = {
						["z"] = actions.cycle_previewers_next,
						["x"] = actions.cycle_previewers_prev,
					},
				},
			},
			git_status = {
				mappings = {
					i = {
						["<C-S>"] = function(prompt_bufnr)
							actions.git_staging_toggle(prompt_bufnr)
							actions.move_selection_previous(prompt_bufnr)
						end,
						["<Tab>"] = function(prompt_bufnr)
							actions.toggle_selection(prompt_bufnr)
							actions.move_selection_previous(prompt_bufnr)
						end,
						["<C-R>"] = reset_selected_files,
					},
					n = {
						["<C-S>"] = function(prompt_bufnr)
							actions.git_staging_toggle(prompt_bufnr)
							actions.move_selection_previous(prompt_bufnr)
						end,
						["<Tab>"] = function(prompt_bufnr)
							actions.toggle_selection(prompt_bufnr)
							actions.move_selection_previous(prompt_bufnr)
						end,
						["<C-R>"] = reset_selected_files,
					},
				},
			},
			git_branches = {
				mappings = {
					i = {
						["<C-V>"] = false,
						["<C-X>"] = false,
						["<C-N>"] = false,
						["<C-P>"] = pull_selected_branches,
					},
					n = {
						["<C-V>"] = false,
						["<C-X>"] = false,
					},
				},
			},
		},
		extensions = {
			file_browser = {
				hijack_netrw = true,
			},
			fzf = {
				fuzzy = true, -- false will only do exact matching
				override_generic_sorter = true, -- override the generic sorter
				override_file_sorter = true, -- override the file sorter
				case_mode = "smart_case", -- or "ignore_case" or "respect_case". the default case_mode is "smart_case"
			},
			telescope_git = {},
		},
	})
end

return {
	"nvim-telescope/telescope.nvim",
	tag = "0.1.0",
	dependencies = { "nvim-lua/plenary.nvim", { "nvim-telescope/telescope-fzf-native.nvim", build = "make" } },
	config = config,
	cmd = { "Telescope" },

	keys = {
		-- file_browser
		{
			"<leader>tf",
			-- Opens the folder parent to the current buffer.
			function()
				require("telescope").extensions.file_browser.file_browser({
					path = string.gsub(vim.api.nvim_buf_get_name(0), [[/[^/]+$]], [[]]),
				})
			end,
			noremap = true,
		},

		-- Notify
		{ "<leader>tn", ":Telescope notify<CR>", noremap = true },
		---------------------- Git --------------------
		{ "<leader>tgb", ":Telescope telescope_git all_branches<CR>", noremap = true },
		{ "<leader>tgd", ":Telescope git_bcommits<CR>", noremap = true },
		{ "<leader>tgc", ":Telescope git_commits<CR>", noremap = true },
		{ "<leader>tgs", ":Telescope git_status<CR>", noremap = true },
		{ "<leader>tgf", ":Telescope git_files<CR>", noremap = true },
		-- Default Telescope
		{ "<leader>tt", ":Telescope<CR>", noremap = true },
		{ "<leader>twt", ":Telescope live_grep<CR>", noremap = true },
		{ -- Live grep current visual selection
			"<leader>tw",
			function()
				function get_visually_selected_text()
					local s_start = vim.fn.getpos("'<")
					local s_end = vim.fn.getpos("'>")
					local n_lines = math.abs(s_end[2] - s_start[2]) + 1
					local lines = vim.api.nvim_buf_get_lines(0, s_start[2] - 1, s_end[2], false)
					lines[1] = string.sub(lines[1], s_start[3], -1)
					if n_lines == 1 then
						lines[n_lines] = string.sub(lines[n_lines], 1, s_end[3] - s_start[3] + 1)
					else
						lines[n_lines] = string.sub(lines[n_lines], 1, s_end[3])
					end
					return table.concat(lines, "\n")
				end
				local visual_text = get_visually_selected_text()
				if string.find(visual_text, "\n") then
					print("Cannot search for text with new line.")
				else
					require("telescope.builtin").live_grep({ default_text = visual_text })
				end
			end,
			mode = "v",
			noremap = true,
		},
		{ "<leader>th", ":Telescope help_tags<CR>", noremap = true },
		{
			"<leader>tp",
			function()
				require("telescope.builtin").resume()
			end,
			noremap = true,
		},
		{ -- Live grep last yanked text
			"<leader>twy",
			function()
				local text = vim.fn.getreg('"')
				if string.find(text, "\n") then
					print("Cannot search for text with new line.")
				else
					require("telescope.builtin").live_grep({ default_text = text })
				end
			end,
			noremap = true,
		},
		{ "<leader>tr", ":Telescope lsp_references<CR>", noremap = true },
	},
}

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
			diagnostics = {
				mappings = {
					i = {
						["<C-s>"] = function(prompt_bufnr)
							local entry = action_state.get_selected_entry()
							print(vim.inspect(entry))
						end,
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
				grouped = true,
				hidden = true,
				respect_gitignore = false,
			},
			undo = {
				mappings = {
					i = {
						["<c-r>"] = require("telescope-undo.actions").restore,
						["<c-d>"] = require("telescope-undo.actions").yank_deletions,
						["<c-y>"] = require("telescope-undo.actions").yank_additions,
					},
					n = {
						["<c-r>"] = require("telescope-undo.actions").restore,
						["<c-d>"] = require("telescope-undo.actions").yank_deletions,
						["<c-y>"] = require("telescope-undo.actions").yank_additions,
					},
				},
			},
			telescope_git = {},
		},
	})
	require("telescope").load_extension("undo")
end

return {
	"nvim-telescope/telescope.nvim",
	tag = "0.1.0",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{
			"nvim-telescope/telescope-fzf-native.nvim",
			build = "make",
		},
		{
			-- "debugloop/telescope-undo.nvim",
			dir = "~/projects/personal/vim-plugins/telescope-undo.nvim",
		},
	},
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
			desc = "Open file browser",
		},
		-- Undo tree
		{ "<leader>tu", "<cmd>Telescope undo<cr>", noremap = true, desc = "Open undo tree" },

		-- Notify
		{ "<leader>tn", ":Telescope notify<CR>", noremap = true, desc = "Open notifications history" },
		---------------------- Git --------------------
		{ "<leader>tgb", ":Telescope telescope_git all_branches<CR>", noremap = true, desc = "Open branch list" },
		{ "<leader>tgd", ":Telescope git_bcommits<CR>", noremap = true, desc = "Open git commits for current file" },
		{ "<leader>tgc", ":Telescope git_commits<CR>", noremap = true, desc = "Open git commits" },
		{ "<leader>tgs", ":Telescope git_status<CR>", noremap = true, desc = "Open git status" },
		{ "<leader>tgf", ":Telescope git_files<CR>", noremap = true, desc = "Open git files" },
		-- Default Telescope
		{ "<leader>tt", ":Telescope<CR>", noremap = true, "Open telescope pickers" },
		{ "<leader>twt", ":Telescope live_grep<CR>", noremap = true, desc = "Open live grep" },
		{ "<leader>th", ":Telescope help_tags<CR>", noremap = true, desc = "Open help window" },
		{
			"<leader>tp",
			function()
				require("telescope.builtin").resume()
			end,
			noremap = true,
			desc = "Resume last picker",
		},
		{ "<leader>tr", ":Telescope lsp_references<CR>", noremap = true, desc = "Open LSP references" },
	},
}

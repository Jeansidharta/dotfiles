return {
	"mrjones2014/smart-splits.nvim",
	config = {
		resize_mode = {
			quit_key = "<ESC>",
			resize_keys = { "<Left>", "<Down>", "<Up>", "<Right>" },
			-- set to true to silence the notifications
			-- when entering/exiting persistent resize mode
			silent = false,
			-- must be functions, they will be executed when
			-- entering or exiting the resize mode
			hooks = {
				on_enter = nil,
				on_leave = nil,
			},
		},
	},
	keys = {
		{
			"<leader><leader>wr",
			function()
				require("smart-splits").start_resize_mode()
			end,
			desc = "start resize mode",
		},
		{
			"<C-Left>",
			function()
				require("smart-splits").move_cursor_left()
			end,
			desc = "move cursor left",
		},
		{
			"<C-Down>",
			function()
				require("smart-splits").move_cursor_down()
			end,
			desc = "move cursor down",
		},
		{
			"<C-Up>",
			function()
				require("smart-splits").move_cursor_up()
			end,
			desc = "move cursor up",
		},
		{
			"<C-Right>",
			function()
				require("smart-splits").move_cursor_right()
			end,
			desc = "move cursor right",
		},
		{
			"<C-S-Left>",
			function()
				require("smart-splits").swap_buf_left()
				require("smart-splits").move_cursor_left()
			end,
			desc = "swap buf left",
		},
		{
			"<C-S-Down>",
			function()
				require("smart-splits").swap_buf_down()
				require("smart-splits").move_cursor_down()
			end,
			desc = "swap buf down",
		},
		{
			"<C-S-Up>",
			function()
				require("smart-splits").swap_buf_up()
				require("smart-splits").move_cursor_up()
			end,
			desc = "swap buf up",
		},
		{
			"<C-S-Right>",
			function()
				require("smart-splits").swap_buf_right()
				require("smart-splits").move_cursor_right()
			end,
			desc = "swap buf right",
		},
	},
}

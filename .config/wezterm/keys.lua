local wezterm = require('wezterm')

return {
	{
		key = 'w',
		mods = 'CTRL|SHIFT',
		action = wezterm.action.DisableDefaultAssignment,
	},
}

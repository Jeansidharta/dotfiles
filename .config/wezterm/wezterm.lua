-- local wezterm = require("wezterm")

local config = {}

config.colors = require("colors")
config.keys = require("keys")

config.use_fancy_tab_bar = false
config.enable_tab_bar = true
config.hide_tab_bar_if_only_one_tab = true
config.window_background_opacity = 0.9

-- Spawn a fish shell in login mode
-- config.default_prog = { "/usr/bin/fish", "-l" }

config.font_size = 16

return config

local wezterm = require("wezterm")
local launch = require("config.launch")
local key_bindings = require("config.key_bindings")

local config = wezterm.config_builder()

launch.apply(config)
key_bindings.apply(config)

config.color_scheme = "rose-pine"

return config

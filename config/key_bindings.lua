local wezterm = require("wezterm")
local act = wezterm.action
local platform = require("utils.platform")

local module = {}

function module.apply(config)
	local mod = {}
	if platform.is_win() or platform.is_linux() then
		mod.SUPER = "ALT"
		mod.SUPER_REV = "ALT|SHIFT"
	elseif platform.is_mac() then
		mod.SUPER = "SUPER"
		mod.SUPER_REV = "ALT|SHIFT"
	end

	config.disable_default_key_bindings = true
	config.leader = { key = "Space", mods = mod.SUPER_REV }

	config.keys = {
		-- CTRL+SHIFT+Space, followed by 'r' will put us in resize-pane
		-- mode until we cancel that mode.
		{
			key = "r",
			mods = "LEADER",
			action = act.ActivateKeyTable({
				name = "resize_pane",
				one_shot = false,
			}),
		},
		-- CTRL+SHIFT+Space, followed by 'a' will put us in activate-pane
		-- mode until we press some other key or until 1 second (1000ms)
		-- of time elapses
		{
			key = "a",
			mods = "LEADER",
			action = act.ActivateKeyTable({
				name = "activate_pane",
				timeout_milliseconds = 1000,
			}),
		},
	}

	config.key_tables = {
		-- Defines the keys that are active in our resize-pane mode.
		-- Since we're likely to want to make multiple adjustments,
		-- we made the activation one_shot=false. We therefore need
		-- to define a key assignment for getting out of this mode.
		-- 'resize_pane' here corresponds to the name="resize_pane" in
		-- the key assignments above.
		resize_pane = {
			{ key = "LeftArrow", action = act.AdjustPaneSize({ "Left", 1 }) },
			{ key = "h", action = act.AdjustPaneSize({ "Left", 1 }) },

			{ key = "RightArrow", action = act.AdjustPaneSize({ "Right", 1 }) },
			{ key = "l", action = act.AdjustPaneSize({ "Right", 1 }) },

			{ key = "UpArrow", action = act.AdjustPaneSize({ "Up", 1 }) },
			{ key = "k", action = act.AdjustPaneSize({ "Up", 1 }) },

			{ key = "DownArrow", action = act.AdjustPaneSize({ "Down", 1 }) },
			{ key = "j", action = act.AdjustPaneSize({ "Down", 1 }) },

			-- Cancel the mode by pressing escape
			{ key = "Escape", action = "PopKeyTable" },
		},

		-- Defines the keys that are active in our activate-pane mode.
		-- 'activate_pane' here corresponds to the name="activate_pane" in
		-- the key assignments above.
		activate_pane = {
			{ key = "LeftArrow", action = act.ActivatePaneDirection("Left") },
			{ key = "h", action = act.ActivatePaneDirection("Left") },

			{ key = "RightArrow", action = act.ActivatePaneDirection("Right") },
			{ key = "l", action = act.ActivatePaneDirection("Right") },

			{ key = "UpArrow", action = act.ActivatePaneDirection("Up") },
			{ key = "k", action = act.ActivatePaneDirection("Up") },

			{ key = "DownArrow", action = act.ActivatePaneDirection("Down") },
			{ key = "j", action = act.ActivatePaneDirection("Down") },
		},
	}
end

return module

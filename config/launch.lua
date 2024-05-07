local platform = require("utils.platform")

local module = {}

function module.apply(config)
	if platform.is_win then
		config.default_prog = { "C:\\Windows\\System32\\WindowsPowerShell\\v1.0\\powershell.exe", "-NoLogo" }
		config.launch_menu = {
			{ label = "Command Prompt", args = { "cmd" } },
		}
	end
end

return module

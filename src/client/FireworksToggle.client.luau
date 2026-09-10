-- Top-right toggle for OTHER players' fireworks.
-- Sets player attribute "FireworksGlobalOn"; FireworksClient reads it before
-- rendering a remote launch. Your own fireworks always play, toggle or not.

local ToggleButton = require(script.Parent:WaitForChild("ToggleButton"))

ToggleButton.new({
	label          = "FIREWORKS",
	attribute      = "FireworksGlobalOn",
	order          = 1,
	onHint         = "Showing everyone's fireworks",
	offHint        = "Others' fireworks hidden",
	keyCode        = Enum.KeyCode.F,
	gamepadKeyCode = Enum.KeyCode.ButtonR3,
	actionName     = "FwGlobalToggle",
})

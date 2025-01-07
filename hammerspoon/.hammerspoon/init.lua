-- Load the Screenkey Spoon
hs.loadSpoon("Screenkey")

-- Initialize the Screenkey Spoon
spoon.Screenkey:init()

-- Bind a hotkey to toggle Screenkey visibility
hs.hotkey.bind({ "cmd", "alt", "ctrl" }, "K", function()
	spoon.Screenkey:toggleShow()
end)

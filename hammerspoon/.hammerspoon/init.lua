-- Load the Screenkey Spoon
hs.loadSpoon("Screenkey")

-- Initialize the Screenkey Spoon (setting up the canvas and key capture functionality)
spoon.Screenkey:init()

-- Bind a hotkey to toggle the visibility of Screenkey
hs.hotkey.bind({ "cmd", "alt", "ctrl" }, "K", function()
	-- Toggle the visibility of the Screenkey canvas on/off
	spoon.Screenkey:toggleShow()
end)

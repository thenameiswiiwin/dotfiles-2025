--- === Screenkey ===
--- A Spoon for displaying key presses on-screen.
--- Author: Huy Nguyen <huyn.nguyen95@gmail.com>
--- Homepage: https://github.com/Hammerspoon/Spoons
--- License: MIT

local obj = {}

-- Metadata
obj.name = "Screenkey"
obj.version = "1.0"
obj.author = "Huy Nguyen <huyn.nguyen95@gmail.com>"
obj.homepage = "https://github.com/Hammerspoon/Spoons"
obj.license = "MIT - https://opensource.org/licenses/MIT"

-- Required Hammerspoon modules
local hs_eventtap = hs.eventtap
local hs_screen = hs.screen
local hs_canvas = hs.canvas
local hs_timer = hs.timer
local hs_mouse = hs.mouse
local hs_keycodes = hs.keycodes
local hs_logger = hs.logger.new("Screenkey")
obj.logger = hs_logger

-- Default configuration with adjustments for macOS 15.2 (Sequoia) and Retina display
obj.config = {
	format = "%H:%M", -- Time format for display
	textFont = "JetBrains Mono", -- Optimized for code readability
	textColor = { hex = "#e7e5da" }, -- Light font color for visibility
	textSize = 36, -- Adjusted for Retina displays
	width = 300, -- Increased width for better display on larger screens
	height = 60, -- Increased height for better legibility
	hotkey = "escape", -- Escape key for toggling display
	hotkeyMods = { "cmd", "alt", "ctrl" }, -- Customizable hotkey modifier combination
}

for k, v in pairs(obj.config) do
	obj[k] = v
end

-- Initialization
function obj:init()
	if not self.canvas then
		self.canvas = hs_canvas.new({ x = 0, y = 0, w = 0, h = 0 })
	end

	-- Canvas setup for a better visibility on Retina displays
	self.canvas[1] = { type = "rectangle", id = "background", fillColor = { hex = "#000" } }
	self.canvas[2] = {
		type = "text",
		text = "",
		textFont = self.textFont,
		textSize = self.textSize,
		textColor = self.textColor,
		textLineBreak = "truncateHead",
		textAlignment = "right",
		frame = { x = "0%", y = "0%", h = "90%", w = "95%" },
	}

	-- Center the canvas on the primary screen
	local mainScreen = hs_screen.primaryScreen()
	local mainFrame = mainScreen:fullFrame()
	self.canvas:frame({
		x = (mainFrame.w - self.width) / 2,
		y = (mainFrame.h - self.height) / 2,
		w = self.width,
		h = self.height,
	})

	-- Drag-and-drop functionality for repositioning the canvas
	self.canvas:canvasMouseEvents(true, true)
	self.canvas:mouseCallback(function(_, event, _, x, y)
		if event == "mouseDown" then
			self.mouseMoveTracker = hs_eventtap
				.new({ hs_eventtap.event.types.leftMouseDragged, hs_eventtap.event.types.leftMouseUp }, function(e)
					if e:getType() == hs_eventtap.event.types.leftMouseUp then
						self.mouseMoveTracker:stop()
						self.mouseMoveTracker = nil
					else
						local mousePosition = hs_mouse.getAbsolutePosition()
						self.canvas:frame({
							x = mousePosition.x - x,
							y = mousePosition.y - y,
							w = self.width,
							h = self.height,
						})
					end
				end)
				.start()
		end
	end)

	-- Key capture setup
	self.keys = {}
	self.keyCount = {}
	self.capture = hs_eventtap.new({ hs_eventtap.event.types.keyDown }, function(event)
		local flags = event:getFlags()
		local character = hs_keycodes.map[event:getKeyCode()]
		local keyCombination = (flags.ctrl and "⌃" or "")
			.. (flags.alt and "⌥" or "")
			.. (flags.cmd and "⌘" or "")
			.. (
				({
					["return"] = "⏎",
					["delete"] = "⌫",
					["escape"] = "⎋",
					["space"] = "␣",
					["tab"] = "⇥",
					["up"] = "↑",
					["down"] = "↓",
					["left"] = "←",
					["right"] = "→",
				})[character]
				or character
				or ""
			)

		-- Reset key capture after 5 seconds of inactivity
		if self.resetTimer then
			self.resetTimer:stop()
		end
		self.resetTimer = hs_timer.doAfter(5, function()
			self.keys = {}
			self.keyCount = {}
			self:updateDisplay()
		end)

		-- Handle repeated key presses
		if self:getLastKey() == keyCombination then
			self.keyCount[keyCombination .. #self.keys] = self.keyCount[keyCombination .. #self.keys] + 1
		else
			table.insert(self.keys, keyCombination)
			self.keyCount[keyCombination .. #self.keys] = 1
		end

		self:updateDisplay()
	end)

	return self
end

-- Update the display with key presses
function obj:updateDisplay()
	local displayText = ""
	for index, key in ipairs(self.keys) do
		if self.keyCount[key .. index] > 1 then
			displayText = displayText .. key .. "×" .. self.keyCount[key .. index]
		else
			displayText = displayText .. key
		end
	end
	self.canvas[2].text = displayText
end

-- Show the canvas
function obj:show()
	if not self.capture then
		self:init()
	end
	self.capture:start()
	self.canvas:show()

	if self.hotkey then
		self.cancelHotkey = hs.hotkey.bind(self.hotkeyMods, self.hotkey, function()
			self:hide()
		end)
	end

	return self
end

-- Hide the canvas
function obj:hide()
	if self.capture then
		self.capture:stop()
	end
	if self.cancelHotkey then
		self.cancelHotkey:delete()
	end
	self.canvas:hide()
end

-- Toggle visibility
function obj:toggle()
	if self.canvas:isShowing() then
		self:hide()
	else
		self:show()
	end
end

-- Get the last key pressed
function obj:getLastKey()
	return self.keys[#self.keys]
end

return obj

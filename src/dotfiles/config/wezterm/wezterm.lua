local wezterm = require("wezterm")
local TERM_META = os.getenv("TERM_META")
local HOSTNAME = os.getenv("HOSTNAME")
-- local HOME = os.getenv("HOME")

-- local c_scheme = "rose-pine-dawn"
local c_scheme = "Solarized (light) (terminal.sexy)"
-- local c_scheme = "NeoSolarized Light"
-- local c_scheme = "Spring"
-- local c_scheme = "dayfox"
-- local c_scheme = "dawnfox"

-- local background_image = HOME .. "/Pictures/wallpaper/spikegungs.jpg"

if TERM_META == "dark" then
	c_scheme = "Catppuccin Mocha"
else
	c_scheme = "Catppuccin Latte"
	-- c_scheme = "Solarized Dark - Patched"
	-- c_scheme = "NeoSolarized Dight"
	-- c_scheme = "nordfox"
	-- c_scheme = "terafox"
	-- background_image = HOME .. "/Pictures/wallpaper/spikegungs.jpg"
end

-- if os.getenv("TERM_META_COLOR_SCHEME")
-- then
--     c_scheme = os.getenv("TERM_META_COLOR_SCHEME")
-- end

-- The art is a bit too bright and colorful to be useful as a backdrop
-- for text, so we're going to dim it down to 10% of its normal brightness
-- local dimmer = { brightness = 0.1 }

-- From Neovim ZenMode https://github.com/folke/zen-mode.nvim
wezterm.on("user-var-changed", function(window, pane, name, value)
	local overrides = window:get_config_overrides() or {}
	if name == "ZEN_MODE" then
		local incremental = value:find("+")
		local number_value = tonumber(value)
		if incremental ~= nil then
			while number_value > 0 do
				window:perform_action(wezterm.action.IncreaseFontSize, pane)
				number_value = number_value - 1
			end
			overrides.enable_tab_bar = false
		elseif number_value < 0 then
			window:perform_action(wezterm.action.ResetFontSize, pane)
			overrides.font_size = nil
			overrides.enable_tab_bar = true
		else
			overrides.font_size = number_value
			overrides.enable_tab_bar = false
		end
	end
	window:set_config_overrides(overrides)
end)

font_size = 18.0
if HOSTNAME == "PV-LT-002" then
	font_size = 12.0
end

return {
	color_scheme_dirs = { "/home/jeff/.config/wezterm/themes" },

	font = wezterm.font_with_fallback({
		"InconsolataGo Nerd Font Mono",
		"GoMono Nerd Font Mono",
		"FiraCode Nerd Font Mono",
		"FiraCode Nerd Font",
		"Hack Nerd Font Mono",
		"Monospace",
	}),

	font_size = font_size,

	use_fancy_tab_bar = true,
	hide_tab_bar_if_only_one_tab = true,
	text_background_opacity = 1.0,
	window_background_opacity = 1.0,
	color_scheme = c_scheme,
	colors = {
		-- Make the selection text color fully transparent.
		-- When fully transparent, the current text color will be used.
		selection_fg = "none",
		-- Set the selection background color with alpha.
		-- When selection_bg is transparent, it will be alpha blended over
		-- the current cell background color, rather than replace it
		selection_bg = "rgba(50% 50% 50% 50%)",
	},
	-- This fixes font/terminal resizing issues when using a tiling WM
	adjust_window_size_when_changing_font_size = false,
	-- background = {
	--     {
	--         source = {
	--             File = background_image
	--         },
	--         -- opacity = 0.1,
	--         repeat_x = 'Mirror',
	--         hsb = dimmer,
	--         attachment = { Parallax = 0.2 },
	--     },
	-- },

	scrollback_lines = 1000000,
	enable_scroll_bar = true,
	default_cursor_style = "BlinkingBar",
	cursor_blink_rate = 500,
	keys = {
		{ key = "LeftArrow", mods = "SHIFT", action = wezterm.action({ ActivateTabRelative = -1 }) },
		{ key = "RightArrow", mods = "SHIFT", action = wezterm.action({ ActivateTabRelative = 1 }) },
		-- {
		-- 	key = "K",
		-- 	mods = "CTRL|SHIFT",
		-- 	action = wezterm.action.Multiple({
		-- 		wezterm.action.ClearScrollback("ScrollbackAndViewport"),
		-- 		wezterm.action.SendKey({ key = "L", mods = "CTRL" }),
		-- 	}),
		-- },
	},
	exit_behavior = "Close",
	term = "wezterm",
}

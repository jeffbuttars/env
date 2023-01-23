local wezterm = require 'wezterm';
local TERM_META = os.getenv("TERM_META")
-- local HOME = os.getenv("HOME")

local rose_pine_dawn = require("lua/rose-pine-dawn")
local rose_pine_moon = require("lua/rose-pine-moon")

local colors = rose_pine_dawn.colors()
local window_frame = rose_pine_dawn.window_frame()


-- local c_scheme = "Solarized (light) (terminal.sexy)"
-- local c_scheme = "Spring"
-- local c_scheme = "dayfox"
-- local c_scheme = "dawnfox"

-- local background_image = HOME .. "/Pictures/wallpaper/spikegungs.jpg"

if (TERM_META == "dark")
then
    -- c_scheme = "Solarized Dark - Patched"
    -- c_scheme = "nordfox"
    -- c_scheme = "terafox"
    -- c_scheme = "rose-pine-moon"
    -- background_image = HOME .. "/Pictures/wallpaper/spikegungs.jpg"
    colors = rose_pine_moon.colors()
    window_frame = rose_pine_moon.window_frame()
end

-- if os.getenv("TERM_META_COLOR_SCHEME")
-- then
--     c_scheme = os.getenv("TERM_META_COLOR_SCHEME")
-- end

-- The art is a bit too bright and colorful to be useful as a backdrop
-- for text, so we're going to dim it down to 10% of its normal brightness
-- local dimmer = { brightness = 0.1 }

return {
    font = wezterm.font("FiraCode Nerd Font Mono"),
    font_size = 18.0,

    use_fancy_tab_bar = true,
    hide_tab_bar_if_only_one_tab = true,

    text_background_opacity = 1.0,

    window_background_opacity = 1.0,
    -- color_scheme = c_scheme,

    colors = colors,
    window_frame = window_frame,

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
        { key = "LeftArrow", mods = "SHIFT", action = wezterm.action { ActivateTabRelative = -1 } },
        { key = "RightArrow", mods = "SHIFT", action = wezterm.action { ActivateTabRelative = 1 } },
    },

    exit_behavior = "Close",
    -- term = "wezterm",
}

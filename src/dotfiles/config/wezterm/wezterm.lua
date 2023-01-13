local wezterm = require 'wezterm';
local TERM_META = os.getenv("TERM_META")
local HOME = os.getenv("HOME")

local c_scheme = "Builtin Solarized Light"
-- local c_scheme = "dayfox"
-- local c_scheme = "dawnfox"
-- local background_image = HOME .. "/Pictures/Wallpaper/spikegungs.jpg"

if (TERM_META == "dark")
then
    -- c_scheme = "Solarized Dark - Patched"
    -- c_scheme = "nordfox"
    c_scheme = "terafox"
end

-- os.setenv("TERM_META_COLOR_SCHEME", c_scheme)

return {
  font = wezterm.font("FiraCode Nerd Font Mono"),
  font_size=14.0,

  use_fancy_tab_bar = true,
  hide_tab_bar_if_only_one_tab = true,

  text_background_opacity = 1.0,

  window_background_opacity = 1.0,
  color_scheme = c_scheme,

  set_environmental_variables = {
      TERM_META_COLOR_SCHEME = c_schema,
  },

  -- window_background_image = background_image,
  -- window_background_image_hsb = {
  --   -- Darken the background image by reducing it to 1/3rd
  --   brightness = 0.01,

  --   -- You can adjust the hue by scaling its value.
  --   -- a multiplier of 1.0 leaves the value unchanged.
  --   hue = 1.0,

  --   -- You can adjust the saturation also.
  --   saturation = 1.0,
  -- },

  scrollback_lines = 1000000,
  enable_scroll_bar = true,

  default_cursor_style = "BlinkingBar",
  cursor_blink_rate = 500,

  keys = {
      {key="LeftArrow", mods="SHIFT", action=wezterm.action{ActivateTabRelative=-1}},
      {key="RightArrow", mods="SHIFT", action=wezterm.action{ActivateTabRelative=1}},
  },

  exit_behavior = "Close",
}

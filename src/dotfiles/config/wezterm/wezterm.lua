local wezterm = require 'wezterm';
return {
  font = wezterm.font("FiraCode Nerd Font Mono"),
  font_size=14.0,

  use_fancy_tab_bar = true,
  hide_tab_bar_if_only_one_tab = true,

  window_background_opacity = 1.0,
  color_scheme = "Solarized Dark - Patched",

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

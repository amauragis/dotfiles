local wezterm = require("wezterm")
local keybinds = require("keybinds")

-- config_builder() warns about misspelled or unknown options
local config = wezterm.config_builder()

-- Not "wezterm": remote hosts rarely have that terminfo, which makes ssh a chore
config.term = "xterm-256color"

config.font = wezterm.font({ family = "Iosevka Term", weight = "Medium" })
config.font_size = 12
config.warn_about_missing_glyphs = false

config.scrollback_lines = 100000
config.launch_menu = { { args = { "btop" } } }

config.colors = {
    foreground = "#bbbbbb",
    background = "#121212",
    cursor_bg = "#bbbbbb",
    cursor_border = "#bbbbbb",
    cursor_fg = "#ffffff",
    selection_bg = "#b5d5ff",
    selection_fg = "#000000",

    ansi = { "#121212", "#fa2573", "#98e123", "#dfd460", "#1080d0", "#8700ff", "#43a8d0", "#bbbbbb" },
    brights = { "#555555", "#f6669d", "#b1e05f", "#fff26d", "#00afff", "#af87ff", "#51ceff", "#ffffff" },

    visual_bell = "#333300",
}

config.window_frame = {
    inactive_titlebar_bg = "#353535",
    active_titlebar_bg = "#2b2042",
    inactive_titlebar_fg = "#cccccc",
    active_titlebar_fg = "#ffffff",
    inactive_titlebar_border_bottom = "#2b2042",
    active_titlebar_border_bottom = "#2b2042",
    button_fg = "#cccccc",
    button_bg = "#2b2042",
    button_hover_fg = "#ffffff",
    button_hover_bg = "#3b3052",
}
config.window_padding = { left = "1cell", right = "1cell", top = "5px", bottom = "5px" }
config.window_decorations = "TITLE | RESIZE"
config.hide_tab_bar_if_only_one_tab = true

config.audible_bell = "Disabled"
config.visual_bell = {
    fade_in_function = "Linear",
    fade_in_duration_ms = 40,
    fade_out_function = "EaseOut",
    fade_out_duration_ms = 150,
}

config.leader = keybinds.leader
config.keys = keybinds.keys

return config

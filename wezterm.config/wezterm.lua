local wezterm = require("wezterm")
local util = require("util")
local keybinds = require("keybinds")

-- set term to wezterm if the def exists.
-- disabled because it makes ssh kind of a chore
local term_cfg = "xterm-256color"
-- if string.find(wezterm.target_triple, 'linux') ~= nil then
--     if os.execute('infocmp wezterm > /dev/null 2>&1') then
--         term_cfg = "wezterm"
--     end
-- end

local font_cfg = wezterm.font_with_fallback({ "Iosevka Term", "JetBrains Mono", "Noto Color Emoji",
    "Symbols Nerd Font Mono", "Last Resort High-Efficiency" })

local config = {
    automatically_reload_config = true,
    term = term_cfg,
    font = font_cfg,
    font_size = 12,
    launch_menu = { {
        args = { "btop" }
    } },
    colors = {
        foreground = "#bbbbbb",
        background = "#121212",
        cursor_bg = "#bbbbbb",
        cursor_border = "#bbbbbb",
        cursor_fg = "#ffffff",
        selection_bg = "#b5d5ff",
        selection_fg = "#000000",

        ansi = { "#121212", "#fa2573", "#98e123", "#dfd460", "#1080d0", "#8700ff", "#43a8d0", "#bbbbbb" },
        brights = { "#555555", "#f6669d", "#b1e05f", "#fff26d", "#00afff", "#af87ff", "#51ceff", "#ffffff" },

        visual_bell = '#333300',
    },
    window_frame = {
        inactive_titlebar_bg = '#353535',
        active_titlebar_bg = '#2b2042',
        inactive_titlebar_fg = '#cccccc',
        active_titlebar_fg = '#ffffff',
        inactive_titlebar_border_bottom = '#2b2042',
        active_titlebar_border_bottom = '#2b2042',
        button_fg = '#cccccc',
        button_bg = '#2b2042',
        button_hover_fg = '#ffffff',
        button_hover_bg = '#3b3052',
        border_left_width = '0.25cell',
        border_right_width = '0.25cell',
        border_bottom_height = '0.125cell',
        border_top_height = '0.125cell',
        border_left_color = '#bbbbbb',
        border_right_color = '#bbbbbb',
        border_bottom_color = '#bbbbbb',
        border_top_color = '#bbbbbb',
    },
    window_padding = {
        bottom = "5px",
        left = "1cell",
        right = "1cell",
        top = "5px",
      },
    leader = keybinds.leader,
    keys = keybinds.keys,
    hide_tab_bar_if_only_one_tab = false,
    window_decorations = "RESIZE|INTEGRATED_BUTTONS",
    visual_bell = {
        fade_in_function = 'Linear',
        fade_in_duration_ms = 40,
        fade_out_function = 'EaseOut',
        fade_out_duration_ms = 150,
    },
    audible_bell = "Disabled",
    warn_about_missing_glyphs = false,
    enable_wayland = false,
}

-- domain_stuff = {
--     unix_domains = {
--         {
--             name = 'unix'
--         },
--     },
--     default_gui_startup_args = { 'connect', 'unix' },
-- }
-- config = util.merge_tables(config, domain_stuff)

return config

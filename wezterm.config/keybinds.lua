local wezterm = require("wezterm")
local act = wezterm.action

local M = {}

-- tmux-style: Super+a, then the key
M.leader = { key = "a", mods = "SUPER" }

M.keys = {
    { key = "a", mods = "LEADER|CTRL", action = act.SendString("\x01") },
    { key = "|", mods = "LEADER|SHIFT", action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
    { key = "\\", mods = "LEADER", action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
    { key = "-", mods = "LEADER", action = act.SplitVertical({ domain = "CurrentPaneDomain" }) },
    { key = "z", mods = "LEADER", action = act.TogglePaneZoomState },
    { key = "c", mods = "LEADER", action = act.SpawnTab("CurrentPaneDomain") },
    { key = "x", mods = "LEADER", action = act.CloseCurrentPane({ confirm = true }) },
    { key = "X", mods = "LEADER|SHIFT", action = act.CloseCurrentTab({ confirm = true }) },
}

-- hjkl moves between panes, HJKL resizes
for key, dir in pairs({ h = "Left", j = "Down", k = "Up", l = "Right" }) do
    table.insert(M.keys, { key = key, mods = "LEADER", action = act.ActivatePaneDirection(dir) })
    table.insert(M.keys, { key = key:upper(), mods = "LEADER|SHIFT", action = act.AdjustPaneSize({ dir, 5 }) })
end

-- 1-9 jump to tabs
for i = 1, 9 do
    table.insert(M.keys, { key = tostring(i), mods = "LEADER", action = act.ActivateTab(i - 1) })
end

return M

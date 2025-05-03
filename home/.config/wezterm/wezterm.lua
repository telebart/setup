local wezterm = require("wezterm")
local sessionizer = require("sessionizer")
local config = wezterm.config_builder()

config.unix_domains = { {
  name = 'unix'
} }
config.default_gui_startup_args = { 'connect', 'unix' }


config.audible_bell = "Disabled"
config.check_for_updates = false
config.adjust_window_size_when_changing_font_size = true
config.use_dead_keys = false
config.window_close_confirmation = "NeverPrompt"
config.window_decorations = "NONE"

config.max_fps = 120
config.front_end = "WebGpu"

config.color_scheme = 'rose-pine-moon'
config.window_background_opacity = 0.92
config.colors = { background = "black", }
config.font = wezterm.font("Fira Code")
config.harfbuzz_features = { "calt=0", "clig=0", "liga=0" }

config.enable_tab_bar = true
config.hide_tab_bar_if_only_one_tab = true
config.show_new_tab_button_in_tab_bar = false
config.tab_bar_at_bottom = true
config.use_fancy_tab_bar = false

config.window_padding = {
  left = 5,
  right = 5,
  top = 5,
  bottom = 1,
}

local act = wezterm.action
config.keys = {
  { key = "p", mods = "ALT", action = wezterm.action_callback(sessionizer.create_or_switch) },
  { key = ".", mods = "ALT", action = wezterm.action_callback(sessionizer.switch)},

  { key = "t", mods = "ALT", action = act.SpawnTab("CurrentPaneDomain")},
  { key = "w", mods = "ALT", action = act.CloseCurrentTab({confirm = false})},
}
for i = 1, 10 do
  table.insert(config.keys, {
    key = tostring(i%10),
    mods = 'ALT',
    action = act.ActivateTab(i - 1),
  })
end

local function tab_title(tab)
  local title = tab.active_pane.title:match("(%S+)%s")
  if title and #title > 0 then
    return tab.tab_index+1 .. " " .. title
  end
  return tab.tab_index+1 .. " " .. "fish"
end

wezterm.on(
  'format-tab-title',
  function(tab)
    local title = tab_title(tab)
    if tab.is_active then
      return {
        { Background = { Color = "#666666" } },
        { Foreground = { Color = "#7aa2f7" } },
        { Attribute = { Intensity = "Bold" } },
        { Text = " " .. title .. " * " },
      }
    else
      return {
        { Attribute = { Intensity = "Bold" } },
        { Foreground = { Color = "#cccccc" } },
        { Text = " " .. title .. " - " },
      }
    end
  end
)

return config

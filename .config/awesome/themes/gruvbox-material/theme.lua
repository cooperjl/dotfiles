local beautiful = require('beautiful')
local gears = require('gears')

local filesystem = gears.filesystem
local dpi = beautiful.xresources.apply_dpi
local theme_assets =beautiful.theme_assets

local themes_path = filesystem.get_themes_dir()

-- inherit default theme
local theme = dofile(themes_path .. "default/theme.lua")
-- load vector assets' generators for this theme

theme.font          = "sans 10"
--theme.font = "JetBrains Mono Medium Nerd Font Complete 10"

theme.bg_normal     = "#1d2021"
theme.bg_focus      = "#3c3836"
theme.bg_urgent     = "#ea6962"
theme.bg_minimize   = "#32302f"
theme.bg_systray    = theme.bg_normal

theme.fg_normal     = "#d4be98"
theme.fg_focus      = "#ddc7a1"
theme.fg_urgent     = theme.bg_normal
theme.fg_minimize   = theme.fg_normal

theme.useless_gap   = dpi(3)
theme.border_width  = dpi(2)
theme.border_normal = theme.bg_minimize
theme.border_focus  = theme.fg_normal
theme.border_marked = "#a9b665"

theme.tooltip_fg = theme.fg_normal
theme.tooltip_bg = theme.bg_normal

-- menu unused, but left set just in case.
theme.menu_height = dpi(16)
theme.menu_width  = dpi(100)

-- Recolor Layout icons:
theme = theme_assets.recolor_layout(theme, theme.fg_normal)

-- Recolor titlebar icons:
--
local function darker(color_value, darker_n)
    local result = "#"
    for s in color_value:gmatch("[a-fA-F0-9][a-fA-F0-9]") do
        local bg_numeric_value = tonumber("0x"..s) - darker_n
        if bg_numeric_value < 0 then bg_numeric_value = 0 end
        if bg_numeric_value > 255 then bg_numeric_value = 255 end
        result = result .. string.format("%2.2x", bg_numeric_value)
    end
    return result
end
theme = theme_assets.recolor_titlebar(
    theme, theme.fg_normal, "normal"
)
theme = theme_assets.recolor_titlebar(
    theme, darker(theme.fg_normal, -60), "normal", "hover"
)
theme = theme_assets.recolor_titlebar(
    theme, theme.bg_urgent, "normal", "press"
)
theme = theme_assets.recolor_titlebar(
    theme, theme.fg_focus, "focus"
)
theme = theme_assets.recolor_titlebar(
    theme, darker(theme.fg_focus, -60), "focus", "hover"
)
theme = theme_assets.recolor_titlebar(
    theme, theme.bg_urgent, "focus", "press"
)

-- Define the icon theme for application icons. If not set then the icons
-- from /usr/share/icons and /usr/share/icons/hicolor will be used.
theme.icon_theme = nil

-- Generate Awesome icon:
theme.awesome_icon = theme_assets.awesome_icon(
    theme.menu_height, theme.bg_focus, theme.fg_focus
)

-- Generate taglist squares:
local taglist_square_size = dpi(4)
theme.taglist_squares_sel = theme_assets.taglist_squares_sel(
    taglist_square_size, theme.fg_normal
)
theme.taglist_squares_unsel = theme_assets.taglist_squares_unsel(
    taglist_square_size, theme.fg_normal
)

theme.wallpaper = "~/Pictures/wallpapers/gruvbox_astro.jpg"
return theme


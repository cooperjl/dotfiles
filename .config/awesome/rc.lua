-- If LuaRocks is installed, make sure that packages installed through it are
-- found (e.g. lgi). If LuaRocks is not installed, do nothing.
pcall(require, "luarocks.loader")

local awful = require("awful")
local beautiful = require("beautiful")
local naughty = require("naughty")

-- Enable hotkeys help widget for VIM and other apps
-- I found this to be buggy and always display TMUX for some reason, so disabled.
-- require("awful.hotkeys_popup.keys")

-- theme
local theme_path = string.format("%s/.config/awesome/themes/%s/theme.lua", os.getenv("HOME"), "gruvbox-material")
beautiful.init(theme_path)

-- load config and signals 
require("config")
require("signals")

-- notification size
naughty.config.defaults['icon_size'] = 80

-- spawn apps
awful.spawn.single_instance("nm-applet")

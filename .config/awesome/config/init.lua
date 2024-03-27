-- settings
modkey = "Mod4"

terminal = "alacritty"
editor = os.getenv("EDITOR") or "nvim"
editor_cmd = terminal .. " -e " .. editor

awesome.set_preferred_icon_size(32)

require("config.bar")
require("config.keys")
require("config.rules")

-- Settings
modkey = "Mod4"

terminal = "alacritty"
editor = os.getenv("EDITOR") or "nvim"
editor_cmd = terminal .. " -e " .. editor


require("config.bar")
require("config.keys")
require("config.rules")
require("config.signals")

local awful = require("awful")
local beautiful = require("beautiful")
local naughty = require("naughty")

-- Rules. 
awful.rules.rules = {
    -- All clients will match this rule.
    { rule = { },
      properties = {
        border_width = beautiful.border_width,
        border_color = beautiful.border_normal,
        focus = awful.client.focus.filter,
        raise = true,
        keys = clientkeys,
        buttons = clientbuttons,
        screen = awful.screen.preferred,
        placement = awful.placement.no_overlap+awful.placement.no_offscreen,
     }
    },

    -- Floating clients.
    { rule_any = {
        instance = { },

        class = {
          "Blueman-manager",
          "Sxiv",
          "Tor Browser", -- Needs a fixed window size to avoid fingerprinting by screen size.
        },

        role = { "pop-up", }

      }, properties = { floating = true }
    },

    -- Add titlebars to normal clients and dialogs.
    { rule_any = { type = { "normal", "dialog" }
      }, properties = { titlebars_enabled = false }
    },

    -- rule to pin discord popout in corner, ontop implied by signal in signals.lua
    -- width and height just manually played with, x=1920-width-4(border), y = 1080-height-4(border)
    { rule = { class = "discord" , name = "Discord Popout" },
      properties = {
        floating = true,
        sticky = true,
        ontop = true,
        width = 800,
        height = 450,
        x = 1756,
        y = 986,
      }
    },

    { rule = { class = "vesktop" , name = "Discord Popout" },
      properties = {
        floating = true,
        sticky = true,
        ontop = true,
        width = 800,
        height = 450,
        x = 1756,
        y = 986,
      }
    },

    { rule = { name = "movie-web" },
      properties = {
        floating = false,
        maximized = false,
        titlebars_enabled = false,
      }
    },


    -- debug rule to find properties of windows
    --{rule = {}, callback = function(c) naughty.notify{ title="new window", text = c.name } end },
}

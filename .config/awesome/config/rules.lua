local awful = require("awful")
local beautiful = require("beautiful")


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

        name = { },

        role = { "pop-up", }

      }, properties = { floating = true }
    },

    -- Add titlebars to normal clients and dialogs.
    { rule_any = { type = { "normal", "dialog" }
      }, properties = { titlebars_enabled = false }
    },
}

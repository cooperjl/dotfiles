local gears = require("gears")
local awful = require("awful")

local wibox = require("wibox")
local beautiful = require("beautiful")

-- Signal function to execute when a new client appears.
client.connect_signal("manage", function (c)
    -- Set the windows at the slave,
    -- i.e. put it at the end of others instead of setting it master.
    -- if not awesome.startup then awful.client.setslave(c) end

    if awesome.startup
      and not c.size_hints.user_position
      and not c.size_hints.program_position then
        -- Prevent clients from being unreachable after screen count changes.
        awful.placement.no_offscreen(c)
    end
end)

-- Add a titlebar if titlebars_enabled is set to true in the rules.
client.connect_signal("request::titlebars", function(c)
    -- buttons for the titlebar
    local buttons = gears.table.join(
        awful.button({ }, 1, function()
            c:emit_signal("request::activate", "titlebar", {raise = true})
            awful.mouse.client.move(c)
        end),
        awful.button({ }, 3, function()
            c:emit_signal("request::activate", "titlebar", {raise = true})
            awful.mouse.client.resize(c)
        end)
    )

    awful.titlebar(c) : setup {
        { -- Left
            awful.titlebar.widget.iconwidget(c),
            buttons = buttons,
            layout  = wibox.layout.fixed.horizontal
        },
        { -- Middle
            { -- Title
                align  = "center",
                widget = awful.titlebar.widget.titlewidget(c)
            },
            buttons = buttons,
            layout  = wibox.layout.flex.horizontal
        },
        { -- Right
            awful.titlebar.widget.floatingbutton (c),
            awful.titlebar.widget.maximizedbutton(c),
            awful.titlebar.widget.stickybutton   (c),
            awful.titlebar.widget.ontopbutton    (c),
            awful.titlebar.widget.closebutton    (c),
            layout = wibox.layout.fixed.horizontal()
        },
        layout = wibox.layout.align.horizontal
    }
end)

-- Enable sloppy focus, so that focus follows mouse.
client.connect_signal("mouse::enter", function(c)
    c:emit_signal("request::activate", "mouse_enter", {raise = false})
end)

-- Mine stolen from overflow, floating should mean ontop
--client.connect_signal("property::floating", function(c)
--    if c.floating then
--        c.ontop = true
--    else
--        c.ontop = false
--   end
--end)

client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)

-- Fix fullscreen apps
client.connect_signal("property::fullscreen", function(c)
    if c.fullscreen then
        gears.timer.delayed_call(function()
            if c.valid then
                -- Fixes bar not being covered by setting correct size.
                c:geometry(c.screen.geometry)

                -- Final steam fix, stops app exiting fullscreen after opening.
                c.fullscreen = true
            end
        end)
    end
end)

-- Steam games, hacky because rules are weird
-- (can only use client properties, not rule properties when looking)
-- This fix is not currently being used (see above signal)
-- Code remains incase I ever need it, above fix still in testing.

-- awesome.register_xproperty("STEAM_GAME", "number")

-- Most games start on fullscreen, can be enabled if I find some which do not

--client.connect_signal("manage", function(c)
--  if c:get_xproperty("STEAM_GAME") ~= nil then c.fullscreen = true end 
--end) 

-- Some games will exit fullscreen (e.g. FROMSOFTWARE games), so stop them exiting
-- limitations:
-- 1. you CANNOT exit fullscreen in a game with keybind
-- 2. if the game has a terminal, or launcher, or other window that also opens 
--    it becomes problematic as that will also be fullscreened.
--    This is especially an issue with a terminal as it will be fullscreen at the
--    same time as the game, which caused visual glitches in my testing.

--client.connect_signal("property::fullscreen", function(c)
--  if c:get_xproperty("STEAM_GAME") ~= nil then c.fullscreen = true end
--end) 


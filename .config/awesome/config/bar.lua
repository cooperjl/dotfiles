-- Standard awesome library
local gears = require("gears")
local awful = require("awful")

local wibox = require("wibox")
local beautiful = require("beautiful")

-- Create a textclock widget, in ISO 8601 format.
mytextclock = wibox.widget.textclock(" %Y-%m-%d %H:%M ")

-- Create a keyboard layout widget
mykeyboardlayout = awful.widget.keyboardlayout()

-- https://awesomewm.org/doc/api/libraries/awful.layout.html for other layouts
awful.layout.layouts = {
    awful.layout.suit.tile,
}

-- Buttons for the taglist widget
local taglist_buttons = gears.table.join(
  awful.button({ }, 1, function(t) t:view_only() end),
  
  awful.button({ modkey }, 1, function(t)
    if client.focus then
      client.focus:move_to_tag(t)  
    end  
  end),

  awful.button({ }, 3, awful.tag.viewtoggle),
  
  awful.button({ modkey }, 3, function(t)
    if client.focus then
      client.focus:toggle_tag(t)
    end
  end),

  awful.button({ }, 4, function(t) awful.tag.viewnext(t.screen) end),
  awful.button({ }, 5, function(t) awful.tag.viewprev(t.screen) end))

-- Buttons for the tasklist widget
local tasklist_buttons = gears.table.join(
  awful.button({ }, 1, function (c)
    if c == client.focus then
      c.minimized = true
    else
      c:emit_signal(
        "request::activate",
        "tasklist",
        {raise = true})
    end
  end),
 -- right click menu, removed 
 -- awful.button({ }, 3, function()
 --   awful.menu.client_list({ theme = { width = 250 } })
 -- end),
  
  awful.button({ }, 4, function ()
    awful.client.focus.byidx(1)
  end),
  
  awful.button({ }, 5, function ()
    awful.client.focus.byidx(-1)  
  end))

-- I feel as if this should not be in bar.lua, but is used in the screen connect ...
local function set_wallpaper(s)
    -- Wallpaper
    if beautiful.wallpaper then
        local wallpaper = beautiful.wallpaper
        -- If wallpaper is a function, call it with the screen
        if type(wallpaper) == "function" then
            wallpaper = wallpaper(s)
        end
        gears.wallpaper.maximized(wallpaper, s, true)
    end
end

awful.screen.connect_for_each_screen(function(s)
    -- Wallpaper
    set_wallpaper(s)

    -- Each screen has its own tag table.
    awful.tag({ "1", "2", "3", "4", "5", "6", "7", "8", "9" }, s, awful.layout.layouts[1])

    -- Create a promptbox for each screen
    s.mypromptbox = awful.widget.prompt()
    -- Create an imagebox widget which will contain an icon indicating which layout we're using.
    -- Removed, as I only want the tiling layout.

    --s.mylayoutbox = awful.widget.layoutbox(s)
    --s.mylayoutbox:buttons(gears.table.join(
    --                       awful.button({ }, 1, function () awful.layout.inc( 1) end),
    --                       awful.button({ }, 3, function () awful.layout.inc(-1) end),
    --                       awful.button({ }, 4, function () awful.layout.inc( 1) end),
    --                       awful.button({ }, 5, function () awful.layout.inc(-1) end)))

    -- Create a taglist widget
    s.mytaglist = awful.widget.taglist {
        screen  = s,
        filter  = awful.widget.taglist.filter.all,
        buttons = taglist_buttons
    }

    -- Create a tasklist widget
    s.mytasklist = awful.widget.tasklist {
        screen  = s,
        filter  = awful.widget.tasklist.filter.currenttags,
        buttons = tasklist_buttons
    }

    -- Create the wibox
    s.mywibox = awful.wibar({ position = "top", screen = s, height = 24 })

    -- Add widgets to the wibox
    s.mywibox:setup {
        layout = wibox.layout.align.horizontal,
        -- Left widgets
        {
            layout = wibox.layout.fixed.horizontal,
            s.mytaglist,
            s.mypromptbox,
        },

        -- Middle widget
        s.mytasklist,

        -- Right widgets
        {
            layout = wibox.layout.fixed.horizontal,
            mykeyboardlayout,
            wibox.widget.systray(),
            mytextclock,
            -- s.mylayoutbox,
        },
    }
end)

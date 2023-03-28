local theme_assets = require("beautiful.theme_assets")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi
local xrdb = xresources.get_current_theme()
local gfs = require("gears.filesystem")
local themes_path = gfs.get_themes_dir()
local shape = require("gears.shape")
local naughty = require("naughty")

local theme = dofile(themes_path.."default/theme.lua")

local font = "Ubuntu Nerd Font"
local font_size = dpi(11)
local gap_size = dpi(10)
local border_size = dpi(2)
local menu_height = dpi(20)
local menu_width = dpi(200)
local taglist_square_size = dpi(5)

local notification_font = "Ubuntu Nerd Font"
local notification_font_size = dpi(13)
local notification_border_color = xrdb.color2
local notification_shape = shape.rounded_rect
local notification_width = dpi(700)
local notification_icon_size = dpi(125)

theme.font          = font .. " " .. tostring(font_size)

theme.bg_normal     = xrdb.background
theme.bg_focus      = xrdb.color12
theme.bg_urgent     = xrdb.color9
theme.bg_minimize   = xrdb.color8
theme.bg_systray    = theme.bg_normal

theme.fg_normal     = xrdb.foreground
theme.fg_focus      = theme.bg_normal
theme.fg_urgent     = theme.bg_normal
theme.fg_minimize   = theme.bg_normal

theme.useless_gap   = gap_size
theme.border_width  = border_size
theme.border_normal = xrdb.color0
theme.border_focus  = theme.bg_focus
theme.border_marked = xrdb.color10
theme.gap_single_client = true

theme.notification_font = notification_font .. " " .. tostring(notification_font_size)
theme.notification_bg = xrdb.background
theme.notification_fg = xrdb.foreground
theme.notification_border_width = border_size
theme.notification_border_color = notification_border_color
theme.notification_shape = notification_shape
-- theme.notification_opacity
theme.notification_margin = gap_size
theme.notification_width = notification_width
theme.notification_icon_size = notification_icon_size

naughty.config.padding = gap_size
naughty.config.spacing = gap_size

naughty.config.presets.critical.bg = xrdb.color1
naughty.config.presets.critical.fg = xrdb.foreground

theme.tooltip_fg = theme.fg_normal
theme.tooltip_bg = theme.bg_normal

theme.menu_submenu_icon = themes_path.."default/submenu.png"
theme.menu_height = menu_height
theme.menu_width  = menu_width

theme = theme_assets.recolor_layout(theme, theme.fg_normal)

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
    theme, xrdb.color1, "normal", "press"
)
theme = theme_assets.recolor_titlebar(
    theme, theme.fg_focus, "focus"
)
theme = theme_assets.recolor_titlebar(
    theme, darker(theme.fg_focus, -60), "focus", "hover"
)
theme = theme_assets.recolor_titlebar(
    theme, xrdb.color1, "focus", "press"
)

theme.icon_theme = nil

theme.awesome_icon = theme_assets.awesome_icon(
    theme.menu_height, theme.bg_focus, theme.fg_focus
)

theme.taglist_squares_sel = theme_assets.taglist_squares_sel(
    taglist_square_size, theme.fg_normal
)
theme.taglist_squares_unsel = theme_assets.taglist_squares_unsel(
    taglist_square_size, theme.fg_normal
)

local bg_numberic_value = 0;
for s in theme.bg_normal:gmatch("[a-fA-F0-9][a-fA-F0-9]") do
    bg_numberic_value = bg_numberic_value + tonumber("0x"..s);
end
local is_dark_bg = (bg_numberic_value < 383)

local wallpaper_bg = xrdb.color8
local wallpaper_fg = xrdb.color7
local wallpaper_alt_fg = xrdb.color12
if not is_dark_bg then
    wallpaper_bg, wallpaper_fg = wallpaper_fg, wallpaper_bg
end
theme.wallpaper = function(s)
    return theme_assets.wallpaper(wallpaper_bg, wallpaper_fg, wallpaper_alt_fg, s)
end

return theme

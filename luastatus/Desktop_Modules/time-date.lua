package.path = package.path .. ";" .. os.getenv("HOME") .. "/Github/dotfiles/luastatus/colorscheme/?.lua"
local color = require("color")
local prefix = color.sep .. color.date_ic_fg .. color.date_ic_bg
local prefix2 = color.sep .. color.time_ic_fg .. color.time_ic_bg

months = {'January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September',
    'October', 'November', 'December'}
widget = {
    plugin = 'timer',
    cb = function()
        local d = os.date('*t')
        return {
            string.format(prefix .. '   ' .. prefix .. color.date_bg .. color.date_fg .. '%d %s', d.day, months[d.month]),
            string.format(prefix2 .. '   ' .. prefix2 .. color.time_bg .. color.time_fg ..  '%d:%02d:%02d', d.hour, d.min, d.sec),
        }
    end,
}

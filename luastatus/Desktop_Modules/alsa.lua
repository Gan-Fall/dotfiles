package.path = package.path .. ";" .. os.getenv("HOME") .. "/Github/dotfiles/luastatus/colorscheme/?.lua"
local color = require("color")
local prefix = color.sep .. color.vol_ic_fg .. color.vol_ic_bg

widget = {
    plugin = 'alsa',
    cb = function(t)
        if t.mute then
            return prefix .. ' 󰝟  '
        else
            local percent = (t.vol.cur - t.vol.min) / (t.vol.max - t.vol.min) * 100
            return string.format(prefix .. '   ' .. color.sep .. color.vol_fg .. color.vol_bg .. '%3d%%', math.floor(0.5 + percent))
        end
    end,
}

package.path = package.path .. ";" .. os.getenv("HOME") .. "/Github/dotfiles/luastatus/colorscheme/?.lua"
local color = require("color")
local prefix = color.sep .. color.mem_ic_fg .. color.mem_ic_bg

widget = luastatus.require_plugin('mem-usage-linux').widget{
    timer_opts = {period = 2},
    cb = function(t)
        local used_kb = t.total.value - t.avail.value
        return string.format(prefix .. '   ' .. color.mem_fg .. color.mem_bg .. '[%3.2f GiB]', used_kb / 1024 / 1024)
    end,
}

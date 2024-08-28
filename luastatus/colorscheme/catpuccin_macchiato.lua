-- get the specific color table from helper.colorschemes module
local c = require("helper.colorschemes")["catppuccin_macchiato"]
local fcolor = require("helper.fcolor")

local color = {
	-- separator
	sep = fcolor("bg", c["crust"]) .. fcolor("fg", c["mantle"]) .. "|",

	-- date
	date_ic_fg = fcolor("fg", c["crust"]),
	date_ic_bg = fcolor("bg", c["red"]),
	date_fg = fcolor("fg", c["maroon"]),
	date_bg = fcolor("bg", c["crust"]),

	-- time
	time_ic_fg = fcolor("fg", c["crust"]),
	time_ic_bg = fcolor("bg", c["pink"]),
	time_fg = fcolor("fg", c["pink"]),
	time_bg = fcolor("bg", c["crust"]),

	-- wifi
	wifi_ic_fg = fcolor("fg", c["crust"]),
	wifi_ic_bg = fcolor("bg", c["blue"]),
	wifi_fg = fcolor("fg", c["blue"]),
	wifi_bg = fcolor("bg", c["crust"]),

	-- battery
	btt_ic_fg = fcolor("fg", c["crust"]),
	btt_ic_bg = fcolor("bg", c["peach"]),
	btt_fg = fcolor("fg", c["peach"]),
	btt_bg = fcolor("bg", c["crust"]),

	-- volume
	vol_ic_fg = fcolor("fg", c["crust"]),
	vol_ic_bg = fcolor("bg", c["mauve"]),
	vol_fg = fcolor("fg", c["mauve"]),
	vol_bg = fcolor("bg", c["crust"]),

	-- brightness
	brgn_ic_fg = fcolor("fg", c["text"]),
	brgn_ic_bg = fcolor("bg", c["crust"]),
	brgn_fg = fcolor("fg", c["text"]),
	brgn_bg = fcolor("bg", c["crust"]),

	-- memory
	mem_ic_fg = fcolor("fg", c["crust"]),
	mem_ic_bg = fcolor("bg", c["peach"]),
	mem_fg = fcolor("fg", c["peach"]),
	mem_bg = fcolor("bg", c["crust"]),
}

return color

-- theme_rosepine.lua
-- Rosé Pine pour WezTerm — 3 variantes : main, moon, dawn
-- Source : https://github.com/neapsix/wezterm

local wezterm = require("wezterm")

-- Chargement du plugin Rosé Pine via le système de plugins WezTerm
local rosepine = wezterm.plugin.require("https://github.com/neapsix/wezterm")

return {
  main = {
    name    = "RosePineMain",
    plugin  = rosepine.main,
  },
  moon = {
    name    = "RosePineMoon",
    plugin  = rosepine.moon,
  },
  dawn = {
    name    = "RosePineDawn",
    plugin  = rosepine.dawn,
  },
}

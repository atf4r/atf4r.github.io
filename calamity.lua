local SAMPLES = require 'sample'
local HTML = require    'html'
local CSS = require     'css'
local Wiki = require    'wiki'

local links = {}
for name, sample in pairs(SAMPLES) do
    links[name] = name .. ".html"
end

for name, sample in pairs(SAMPLES) do
    local f = io.open(name .. ".html", "w")
    if f == nil then error("Couldnt open file") end
    f:write(Wiki.Page(name, sample, Wiki.Navbar("Samples Browser", links, name)))
    f:close()
end
local CSS = {
    Indentation = '\t'
}

local HTML = require "html"

function CSS.SQ(str)
	return string.format([['%s']], str)
end

function CSS.DQ(str)
	return string.format([["%s"]], str)
end

function CSS.RGBA(...)
	local rgba = {...}

    -- Ensure that the RGBA values are in the range [0, 1]
    local r, g, b, a = rgba[1], rgba[2], rgba[3], rgba[4]

    -- Convert the components to 8-bit values and then to hexadecimal strings
    r, g, b, a = math.floor(r * 255), math.floor(g * 255), math.floor(b * 255), math.floor(a * 255)
    local hexR = string.format("%02X", r)
    local hexG = string.format("%02X", g)
    local hexB = string.format("%02X", b)
    local hexA = string.format("%02X", a)

    -- Combine the components into a 32-bit hexadecimal value
    local hexCode = "0x" .. hexA .. hexR .. hexG .. hexB

    return hexCode
end

function CSS.HSVA(h, s, v, a)
	-- Ensure h, s, v, and a are within valid ranges
	h = h % 360
	s = math.max(0, math.min(1, s))
	v = math.max(0, math.min(1, v))
	a = math.max(0, math.min(1, a))
  
	local c = v * s
	local x = c * (1 - math.abs((h / 60) % 2 - 1))
	local m = v - c
  
	local r, g, b
  
	if h >= 0 and h < 60 then
	  r, g, b = c, x, 0
	elseif h >= 60 and h < 120 then
	  r, g, b = x, c, 0
	elseif h >= 120 and h < 180 then
	  r, g, b = 0, c, x
	elseif h >= 180 and h < 240 then
	  r, g, b = 0, x, c
	elseif h >= 240 and h < 300 then
	  r, g, b = x, 0, c
	else
	  r, g, b = c, 0, x
	end
  
	r = (r + m) * 255
	g = (g + m) * 255
	b = (b + m) * 255
  
	-- Convert the RGB values to hexadecimal format
	local hex = string.format("#%02X%02X%02X%02X", math.floor(r), math.floor(g), math.floor(b), math.floor(a * 255.0))
  
	return hex
  end
  

function CSS.HEX(hex)
	if ((#hex == #"#FF00FF") or (#hex == #"#00FF00FF")) and (string.sub(hex, 1, 1) == "#") then
		return hex
	else
		error("Malfored hex code")
	end

    return hex
end

function CSS.RExpr(rxp)
	if type(rxp) ~= "table" then return tostring(rxp) end

	local pre = rxp[1] -- string
	rxp[1] = nil

	if not pre then
		error("Malformed RExpr")
	end

	local out = pre .. " {\n"

	for left, right in pairs(rxp) do
		if type(left) == "string" then
			out = out .. CSS.Indentation .. string.format("%s: %s;\n", left, right)
		elseif type(left) == "number" then
			if type(right) == "table" then
				right = HTML.Indent(CSS.RExpr(right))
			end
			out = out .. right
		end
	end

	out = out .. "}\n"

	return out
end

function CSS.Scope(pre, ...)
	local rxps = {pre}
	for _,c in pairs({...}) do
		if type(c) ~= "table" then
			rxps[#rxps+1] = HTML.EnsureNewline(tostring(c)):sub(1, -2)
		else
			rxps[#rxps+1] = c
		end
	end
	return rxps
end

function CSS.PSExpr(...)
	local sheet = ""
	for _, rexpr in pairs({...}) do
		sheet = sheet .. CSS.RExpr(rexpr)
	end
	return sheet
end

function CSS.URL(str)
	return string.format([[url('%s')]], str)
end

function CSS.CLASS(str)
	return string.format(".%s", str)
end

function CSS.COMB(sp, ...)
	local r = ""
	local items = {...}
	for _, item in pairs(items) do
		r=r.. item .. sp
	end

	r=string.sub(r, 1, -(#sp+1))

	return r
end

function CSS.ANY(...)
	return CSS.COMB(', ', ...)
end

return CSS
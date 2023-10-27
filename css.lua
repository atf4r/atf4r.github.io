local CSS = {
    Indentation = '\t'
}

function CSS.Indent(text)
	-- Split the text into lines using the newline character (\n) as the delimiter
	local lines = {}
	for line in string.gmatch(text or "", "[^\n]+") do
		table.insert(lines, line)
	end

	-- Add four spaces before each line and concatenate the lines
	local indentedText = ""
	for _, line in ipairs(lines) do
		indentedText = indentedText .. CSS.Indentation .. line .. "\n"
	end

	return indentedText
end

function CSS.EnsureNewline(text)
	if string.sub(text, -1) ~= "\n" then
		return text .. "\n"
	else
		return text
	end
end

function CSS.StripNewline(text)
    return CSS.EnsureNewline(text):sub(1, -2)
end

function CSS.Str(t) return string.format([["%s"]], t) end

function CSS.Property(k, v)
    return CSS.EnsureNewline(string.format("%s: %s;",k,v))
end

function CSS.HRule(q, b)
    return string.format("%s {%s};\n", CSS.StripNewline(q), CSS.StripNewline(b))
end

function CSS.VRule(q, b)
    return string.format("%s {\n%s\n};", CSS.StripNewline(q), CSS.Indent(CSS.StripNewline(b)))
end

return CSS
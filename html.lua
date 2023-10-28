local HTML = {
	USE_BOOTSTRAP = false,

	BOOTSTRAP_CDN_STUB = 
[[<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>]],

	Indentation = "\t"
}

function HTML.INCLUDE_CSS(link)
	return { "link", {rel="stylesheet", href=link}}
end

function HTML.STag(t, props)
	
	local preamble = string.format("<%s", t)

	if type(props)=="table" then
		for i,v in pairs(props) do
			preamble = preamble .. string.format([[ %s="%s"]], i, v)
		end
	elseif props == nil then
		preamble = preamble
	else
		error("Unexpected argument #3, properties should be a table")
	end

	preamble = preamble .. ">\n"

	return preamble
end

function HTML.HTag(t, props, c)

	local preamble = string.format("<%s", t)

	if type(props)=="table" then
		for i,v in pairs(props) do
			preamble = preamble .. string.format([[ %s="%s"]], i, v)
		end
	elseif props == nil then
		preamble = preamble
	else
		error("Unexpected argument #3, properties should be a table")
	end

	preamble = preamble .. ">"

	return preamble .. string.sub(HTML.EnsureNewline(c or ""), 1, -2) .. string.format("</%s>\n", t)
end

function HTML.Indent(text)
	-- Split the text into lines using the newline character (\n) as the delimiter
	local lines = {}
	for line in string.gmatch(text or "", "[^\n]+") do
		table.insert(lines, line)
	end

	-- Add four spaces before each line and concatenate the lines
	local indentedText = ""
	for _, line in ipairs(lines) do
		indentedText = indentedText .. HTML.Indentation .. line .. "\n"
	end

	return indentedText
end

function HTML.EnsureNewline(text)
	if string.sub(text, -1) ~= "\n" then
		return text .. "\n"
	else
		return text
	end
end

function HTML.VTag(t, props, c)

	local preamble = string.format("<%s", t)

	if type(props)=="table" then
		for i,v in pairs(props) do
			preamble = preamble .. string.format([[ %s="%s"]], i, v)
		end
	elseif props == nil then
		preamble = preamble
	else
		error("Unexpected argument #3, properties should be a table")
	end

	preamble = preamble .. ">\n"

	return preamble .. HTML.EnsureNewline(HTML.Indent(c)) .. string.format("</%s>\n", t)
end

function NumNewLines(inputString)
	local count = 0
	for i = 1, #inputString do
		if inputString:sub(i, i) == "\n" then
			count = count + 1
		end
	end
	return count
end

function TableSub(table, startIndex, endIndex)
	local result = {}
	for i = startIndex, (endIndex or #table) do
		result[#result+1]=table[i]
	end
	return result
end

function HTML.VExpr(vex)
	if type(vex) ~= "table" then
		return tostring(vex) or vex
	end

	local tag = vex[1]
	local props = vex[2]
	local args = TableSub(vex, 3)

	if #args<= 0 then
		return HTML.STag(tag, props)
	end

	local content = ""

	for _, svex in pairs(args) do
		if type(svex)=="table" then
			content = content .. HTML.EnsureNewline(HTML.VExpr(svex))
		else
			content = content .. string.sub(HTML.EnsureNewline(tostring(svex)), 1, -2)
		end
	end

	if string.match(content, "\n") then
		return HTML.VTag(tag, props, content)
	else
		return HTML.HTag(tag, props, content)
	end    
end

function HTML.PExpr(...)
	local r = ""
	for i,v in pairs({...}) do
		r = r .. HTML.EnsureNewline(HTML.VExpr(v))
	end
	return r
end

return HTML
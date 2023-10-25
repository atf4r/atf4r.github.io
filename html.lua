local HTML = {
    USE_BOOTSTRAP = false,

    BOOTSTRAP_CDN_STUB = 
[[<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>]],

    Indentation = "\t"
}

function alphapairs(t)
    local keys = {}
    for key, _ in pairs(t) do
        table.insert(keys, key)
    end
    table.sort(keys)

    local index = 0

    return function()
        index = index + 1
        if keys[index] then
            local key = keys[index]
            return key, t[key]
        end
    end
end

function HTML.HTag(t, c, props)

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

    return preamble .. HTML.EnsureNewline(HTML.Indent(c or "")) .. string.format("</%s>\n", t)
end

HTML.Indent = HTML.IndentTab

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

function HTML.VTag(t, c, props)

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

function cats(delim,...)
    local r = ""
    for _,s in pairs({...}) do
        r = r .. delim .. s
    end
    r = string.sub(r, #delim + 1, -1)
    return r
end

function OrderedList(list)
    local str = ""

    for key,val in pairs(list) do
        local inner
        
        if type(val) == "table" then
            inner = KeyValuePairs(list)
        else
            if not HTML.USE_BOOTSTRAP then
                inner = HTML.HTag("code",
                    list
                )
            else
                inner = list
            end
        end

        str =
            str .. '\n' .. 
            HTML.VTag("ol",
                inner
            )
    end

    str = string.sub(str, 2, -1)

    str = HTML.VTag("ul", str, {class=list_class}) -- wrap body in element

    return str
end

--[[
    <div class="ms-2 me-auto">
      <div class="fw-bold">Subheading</div>
      Cras justo odio
    </div>
]]

local secondaryBackground = "bg-dark"

local STYLE_PRIMARY_BG = "background-color:#2e3133;"
local STYLE_SECONDARY_BG = "background-color:#17181a;"
local STYLE_BOLD_FG = "color:#f5c542;"
local STYLE_PROPERTY_FG = "color:#FFFFFF;"

function HTML.TitleSubtextPairs(tab, format, tag, hideKey, ...)
    local buf = ""
    for key, val in alphapairs(tab) do
        local heading = HTML.HTag("div", key, {class="fw-bold", style=STYLE_SECONDARY_BG..STYLE_BOLD_FG})
        local text
        if type(val) == "table" then
            text = HTML.TitleSubtextPairs(val, format[key], tag, hideKey, ...)
        else
            text = HTML.VTag("div",
                            HTML.VTag("div container-flex",tostring(val), {class="col-4", style=STYLE_SECONDARY_BG..STYLE_PROPERTY_FG})..
                            HTML.VTag("div container-flex",tostring(format[key]), {class="col", style=STYLE_SECONDARY_BG}),
                        {class="row " .. secondaryBackground})
        end

        local itemContent = (HTML.EnsureNewline(heading) .. HTML.EnsureNewline(text))

        buf = buf .. HTML.VTag("li", itemContent, {class="list-group-item text-secondary", style=STYLE_SECONDARY_BG})
    end

    buf = HTML.VTag("ul", buf, {class="list-group", style=STYLE_SECONDARY_BG})

    return buf
end


function HTML.KeyValuePairs(tab, tag, hideKey, ...)
    local list_class = nil
    local item_class = nil
    if HTML.USE_BOOTSTRAP then
        if hideKey then
            list_class = "list-group list-group-numbered"
        else
            list_class = "list-group"
        end
        item_class = "list-group-item"
    end
    tag = tag or "ul"

    local str = ""

    for key,val in alphapairs(tab) do
        local inner
        
        if type(val) == "table" then
            if hideKey then
                inner = HTML.KeyValuePairs(val, "ul", false, ...)
            else
                inner = HTML.EnsureNewline(HTML.HTag("code", key .. " =")) .. HTML.KeyValuePairs(val, "ul", false, ...)
            end
        else
            if not hideKey then
                inner = key " = " .. val
                if not HTML.USE_BOOTSTRAP then
                    inner = HTML.HTag("code",
                        inner
                    )
                end
            else
                inner = val
                if not HTML.USE_BOOTSTRAP then
                    inner = HTML.HTag("code",
                        val
                    )
                end
            end
        end

        str =
            str .. '\n' .. 
            HTML.VTag("li",
                inner,
                {class=item_class}
            )
    end

    str = string.sub(str, 2, -1)

    str = HTML.VTag(tag, str, {class=list_class}) -- wrap body in element

    return str
end


return HTML
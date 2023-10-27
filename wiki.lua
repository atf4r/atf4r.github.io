local WIKI = {}

local HTML = require('html')
local SAMPLES = require('sample')

HTML.Indentation = "\t"

function NumNewLines(inputString)
    local count = 0
    for i = 1, #inputString do
        if inputString:sub(i, i) == "\n" then
            count = count + 1
        end
    end
    return count
end

function Lines(tb)
    local out = ""
    for key, value in pairs(tb) do
        out = out .. value .. '\n'
    end
    out = HTML.EnsureNewline(out)
    return out
end

WIKI.PAGE_HEAD = 
{"head", {},
    {"title", {}, "Test Site"},

    {"link", {
        rel="stylesheet", 
        href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/css/bootstrap.min.css"
    }},

    {"meta", {
        charset="UTF-8",
        name="viewport", 
        content="width=device-width, initial-scale=1.0"
    }},

    {"style", {}, 
        [[
        .center-viewport {
            position: absolute;
            left: 50%;
            transform: translate(-50%);
        }
        
        .tabulator {
            display: inline-block;
            width: 40px;
        }
        ]]
    }
}

function WIKI.Navbar(brand, links, active)
    local nav = 
    {"nav", {class="navbar navbar-expand-lg sticky-top navbar-dark bg-dark text-light"}
    }

    local div = {"div", {class="container-fluid"},
        {"a", {class="navbar-brand bg-dark text-light", href="#"}, brand}
    }

    for label, link in pairs(links) do
        local extraClasses = " bg-secondary"
        if active == label then
            extraClasses = " bg-primary" 
        end
        table.insert(div, {"a", {class="list-group-item list-group-item-action text-light"..extraClasses, href=link}, label})
    end
    
    table.insert(nav, div)

    return nav
end

function WIKI.SectionList(links, active)
    local div = 
    {"div", {class="col bg-dark text-light"},
        {"div", {class="list-group bg-dark text-light"}}
    }

    for label, link in pairs(links) do
        local extraClasses = " bg-secondary text-light"
        if active == label then
            extraClasses = " bg-primary text-light" 
        end
        table.insert(div, {"a", {class="list-group-item list-group-item-action"..extraClasses, href=link}, label})
    end

    return div
end

function WIKI.Section(title, content, titleSize)
    return  {"h1", {class="row display-"..(titleSize or 4)}, title},
            {"p", {class="row"}, content}
end

function WIKI.Page(title, content, navbar, ...)
    return 
    HTML.PExpr(
        {
            "html", {lang="en"},
            WIKI.PAGE_HEAD,
            {"body", {class="container row bg-dark text-light"},
                {"div", {class="col justify-content-center"},
                    WIKI.Section(title, content)
                },
            },
        }
    )
end

return WIKI
local SAMPLES = require 'sample'
local PAGES = require   'pages'
local HTML = require    'html'
local CSS = require     'css'
local Wiki = require    'wiki'

local links = {}

for name, doc in pairs(PAGES) do
    links[doc.metadata.title] = doc.metadata.fileName .. ".html"
end

for i, doc in pairs(PAGES) do
    local f = io.open(doc.metadata.fileName .. ".html", "w")
    local content = ""

    local sections = {}

    local i = 1
    for title, body in pairs(doc.content) do
        local id = doc.metadata.fileName .. "_" .. i
        content = content ..
        HTML.PExpr(
            {"div", {class="row", id=id}, body},
            {"hr"}
        )
        sections[title] = "#"..id

        i=i+1
    end

    local page = HTML.PExpr(
        {
            "html", {lang="en", ["data-bs-theme"]="dark"},
            Wiki.PAGE_HEAD,
            {"body", {class="bg-dark text-light"},
                Wiki.Navbar("4R", links),
                {"div", {class="row container-fluid bg-dark text-light"},
                    {"div", {class="col-2 bg-dark text-light"},
                        Wiki.SectionList(sections),
                    },
                },
                {"div", {class="col-8 bg-dark text-light"},
                    Wiki.Section(doc.metadata.title, content)
                },
            }
        }
    )

    f:write(page)
    f:close()
end

table.sort(SAMPLES)
for name, sample in pairs(SAMPLES) do
    local f = io.open(name .. ".html", "w")
    if f == nil then error("Couldnt open file") end
    f:write(Wiki.Page(name, sample, Wiki.Navbar("Samples Browser", links, name)))
    f:close()
end
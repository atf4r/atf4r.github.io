local html = require "html"
local wiki = require "wiki"

local bases = {
    GunConfig = require "database"
}

function RecursiveList(tb, lt, et)
    local content = ""
    for k,v in pairs(tb) do
        if type(v) == "table" then
            content = content .. html.VTag(et or "li", {class="list-group-item bg-secondary text-light"},
                string.format("<strong>%s</strong>: {\n%s}", k, RecursiveList(v))
            )
        else
            content = content .. html.VExpr({et or "li", {class="list-group-item bg-secondary text-light"}, string.format("<strong>%s</strong> : %s", k, v)})
        end
    end
    return html.VTag(lt or "ul", {class="list-group text-light bg-secondary"}, content)
end

function HyperlinkList(links)
    local content = {"ul", {}}

    for label, dest in pairs(links) do
        content[#content+1] = {"li", {class="btn-dark btn"}, {"a", {href=dest}, label} }
    end

    return content
end

function Columns(...)
    local content = {}

    for _, vexpr in pairs({...}) do
        content[#content+1] = {"div", {class="col"}, vexpr}
    end

    return {"div", {class="row"}, table.unpack(content)}
end

function Rows(...)
    local content = {}

    for _, vexpr in pairs({...}) do
        content[#content+1] = {"div", {class="row"}, vexpr}
    end

    return {"div", {class="col"}, table.unpack(content)}
end

function BaseView(base)
    local FORMAT = base.FORMAT
    base.FORMAT = nil

    local content = RecursiveList(base)

    base.FORMAT = FORMAT

    return content
end

local links = {}

for gun, _ in pairs(bases.GunConfig) do
    links[gun] = gun..".html"
end

links.FORMAT = nil

local navigation = {"div", {class="row container-fluid bg-dark text-light sticky-top"},
    {"div", {class="col-2 bg-dark text-light"},
        wiki.SectionList(links, "test"),
    },
}

for key, value in pairs(bases.GunConfig) do
    if key ~= "FORMAT" then
        local f = io.open(key..".html","w")
        if not f then
            print("Oh no! Anyways...")
        else
            local view = 
            {"body", {class="container col bg-dark text-light"},
                {"h1", {class="display-4"}, "GunConfig"},
                {"div", {class="row"},
                    {"div", {class="col-md-1"},
                        {"div", {class="row"},
                            HyperlinkList(links)
                        }
                    },
                    {"div", {class="col"},
                        {"div", {class="row"},
                            {"div", {class="col bg-dark text-light"}, 
                                {"h3", {class="display-8"}, key},
                                RecursiveList(value)
                            },
                            {"div", {class="col bg-dark text-light"}, 
                                {"h3", {class="display-8"}, "Format"},
                                RecursiveList(bases.GunConfig.FORMAT)
                            }
                        }
                    }
                }
            }

            local page = html.PExpr(
                {"html", {lang="en"},
                    wiki.PAGE_HEAD,
                    view
                })

            f:write(page)
            f:close()
        end
    end
end


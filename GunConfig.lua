#!/bin/lua

local STYLE_PRIMARY_BG = "background-color:#2e3133;"
local STYLE_SECONDARY_BG = "background-color:#17181a;"
local STYLE_BOLD_FG = "color:#f5c542;"
local STYLE_PROPERTY_FG = "color:#FFFFFF;"

local GUNS = require("database")

local PAGES = {
    --[[
    ["GunConfig Format"] = {
        TITLE = "GunConfig Format",
        API_VERSION = 1,
        DOCUMENTATION = FORMAT
    },]]--
}

local HTML = require('html')
HTML.USE_BOOTSTRAP = true


--[[
    <a href="index.html" style="text-decoration: none; color: #000;">
        <div style="font-size: 10em; text-align: center; line-height: 1em; height: 100vh; display: flex; align-items: center; justify-content: center;">
            <span>#</span>
        </div>
    </a>
]]
local BACKBUTTON = HTML.ITag("a", {href="index.html", style="text-decoration:none;"},
    HTML.ITag("div", {style="font-size: 10em; text-align: center; line-height: 1em; height: 100vh; display: flex; align-items: center; justify-content: center;"},
        HTML.ITag("span", nil, '#')
    )
)

local function createNavLi(gunName)
    return HTML.HTag("li",
        HTML.HTag("a",gunName,{class="nav-link active", href=string.format("./%s.html", gunName)}),
        {class="nav-item"}
    )
end

local function createNavLiLabel(text)
    return HTML.HTag("li",
        HTML.HTag("h4",text, {class="display-8"}),
        {class="nav-item"}
    )
end

--[[

<li class="nav-item">
                            <h4 class="display-8">
                                Guns
                            </h4>
                        </li>
]]

local NAVBAR_CONTENT = ""

for GUN_NAME, _ in pairs(GUNS) do
    NAVBAR_CONTENT = NAVBAR_CONTENT ..
    HTML.ITag("li", {class="nav-item"},
        HTML.ITag("a", {class="nav-link", href=string.format("%s.html", GUN_NAME)},
            GUN_NAME
        )
    )
end

local NAVBAR = HTML.ITag("nav",{class="col-md-3 col-lg-2 d-md-block sidebar", id="sidebar"},
    HTML.ITag("div",{class="position-sticky"}, 
        HTML.ITag("ul", {class="nav flex-column"},
            HTML.ITag("li", {class="nav-item"},
                HTML.ITag("h4", {class="display-8"}, 
                    "Guns"
                )
            )..
            NAVBAR_CONTENT
        )
    )
)

local NAVITEMS = createNavLiLabel("Guns")
for name, gun in alphapairs(GUNS) do
    NAVITEMS = NAVITEMS .. createNavLi(name)
end

local SIDEBAR = HTML.VTag("nav",
        HTML.VTag("div",
            HTML.VTag("ul",
                NAVITEMS,
                {class="nav flex-column"}
            ),
            {class="position-sticky"}
        ),
        {class="col-md-1 d-md-block sidebar", id="sidebar", style=STYLE_PRIMARY_BG}
    )

for title, config in pairs(GUNS) do
    local f = io.open(title .. ".html", "w")

    local DATA = {}

    local BODY = HTML.VTag("body",
        HTML.VTag("div",
            BACKBUTTON..
            NAVBAR..
            HTML.VTag("main",
            HTML.HTag("h1", title, {class="display-4 bg-dark text-light"})..
            HTML.VTag("div",
                HTML.HTag("h1", TITLE, {class="display-6"}) ..
                HTML.TitleSubtextPairs(config, FORMAT, "ol", true),
                {class="container bg-dark text-light"}
            ), {class="col-lg-9"}),
            {class="row container-fluid"}
        ),
        {class="bg-dark container-fluid text-light w-100 ", style="width:100vw;"}
    )

    -- use the bootstrap stub template
    local HEAD = HTML.VTag("head",
        HTML.EnsureNewline(HTML.BOOTSTRAP_CDN_STUB)..
        [[<meta name="viewport" content="width=device-width, initial-scale=1.0">]]
    )

    local ROOT = HTML.VTag("html", HEAD .. BODY, {class="bg-dark text-light"})

    f:write(ROOT)
    f:close()
end

local indexFile = io.open("index.html", "w")

local content = ""

for GUN_NAME, _ in alphapairs(GUNS) do
    content = content .. 
    HTML.VTag("li",
        HTML.HTag("a", 
            GUN_NAME, 
            {
                href=string.format("%s.html", GUN_NAME)
            }
        ),
        {class="list-group-item bg-dark"}
    ),
    {class="list-group mt-3", style=STYLE_SECONDARY_BG}
end

local BROWSEBODY = HTML.VTag("body",
        HTML.VTag("div",
            HTML.HTag("h1", "Gun Configs", {class="mt-4", style=STYLE_SECONDARY_BG..STYLE_BOLD_FG})..
            HTML.VTag("ul", 
                content
            ),
            {class="container text-light", style=STYLE_SECONDARY_BG}
        ),
        {style=STYLE_SECONDARY_BG}
    )

    local HEAD = HTML.VTag("head",
        HTML.EnsureNewline(HTML.BOOTSTRAP_CDN_STUB)
    )
    
    local ROOT = HTML.VTag("html", HEAD .. BROWSEBODY, {class="text-light", style=STYLE_SECONDARY_BG})
    indexFile:write(ROOT)
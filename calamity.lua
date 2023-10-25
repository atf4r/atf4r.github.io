#!/bin/lua

local FORMAT = {
    simulateChamber = "(boolean) Simulates a closed bolt chamber, allowing for one additional bullet to be loaded irrespective of the magazine.",
    ammoCapacity = "(integer) Amount of bullets the magazine can store. [1, inf)",
    rpm = "(number) Rate of fire expressed in rounds per minute. (0, ~900]",

    description = "(string) A brief but rich description of the gun, its capabilities, and personality.",

    TrajectoryProfile = {
        InitialSpeed = "(number) Muzzle velocity magnitude in studs per second (0, inf)",
        MaxRebounds = "(integer) Amount of possible ricochets, lower values = higher performance. [0, ~5)",
        MaxDistance = "(number) Maximum travel distance, lower values = higher performance. (0, inf)",
        DragInfluence = "(number) [unused] amount of acceleration against the bullet in st/s^2",
        DropInfluence = "(number) Bullet gravity multiplier, (-inf, inf)",
        WindInfluence = "(number) Amount of acceleration in st/s multiplied by normal vector wind [0, inf)",

        PierceFriction = "(number) Multiplier to penetration speed deficit upon piercing a part [0, inf)",
        PierceDeviation = "(number) Multiplier to directional influence of the normal vector upon piercing [0, inf)"
    }
}

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
        {class="col-md-1 col-lg-1 d-md-block sidebar", id="sidebar", style=STYLE_PRIMARY_BG}
    )

for title, config in pairs(GUNS) do
    local file = io.open(title .. ".html", "w")

    local DATA = {}

    local BODY = HTML.VTag("body",
        HTML.VTag("div",
            HTML.VTag("main",
            HTML.HTag("h1", title, {class="display-4 bg-dark text-light"})..
            HTML.VTag("div",
                HTML.HTag("h1", TITLE, {class="display-6"}) ..
                HTML.TitleSubtextPairs(config, FORMAT, "ol", true),
                {class="container bg-dark text-light"}
            ), {class="col-md-9 ms-sm-auto col-lg-10 px-md-4"}),
            {class="row"}
        ),
        {class="container bg-dark text-light"}
    )

    -- use the bootstrap stub template
    local HEAD = HTML.VTag("head",
        HTML.EnsureNewline(HTML.BOOTSTRAP_CDN_STUB)..
        [[<meta name="viewport" content="width=device-width, initial-scale=1.0">]]
    )

    local ROOT = HTML.VTag("html", HEAD .. BODY, {class="bg-dark text-light"})

    file:write(ROOT)
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
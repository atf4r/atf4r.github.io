local WIKI = require 'wiki'
local HTML = require 'html'

local CONTENT_FACTIONS =
[[
The factions in "After the Flash" vary greatly in terms of size, power, and objectives. Some are highly organized and militaristic, aiming to establish order and control in the chaotic world left behind after the apocalyptic event. These factions often have well-defined hierarchies and strict rules. Others are more loosely organized, focusing on survival and self-preservation rather than dominance. They might consist of nomadic scavengers or isolated settlements, each struggling to navigate the challenges of the post-apocalyptic environment.

Each faction in "After the Flash" has its own backstory, motivations, and unique characteristics, which contribute to the game's rich lore. Players often choose to align themselves with a specific faction, which not only impacts their role in the game but also the alliances and conflicts they will encounter. This dynamic faction system adds depth and replayability to the "After the Flash" series, as players can explore different storylines and experiences by joining various factions and adapting to their respective ideologies and goals.
]]
CONTENT_FACTIONS = CONTENT_FACTIONS:gsub("\n", "<br>\n")

local CONTENT_CDF =
[[
The Civilian Defense Front (CDF) is a prominent faction in the "After the Flash" universe, known for its unique and somewhat controversial approach to survival and community building. The CDF's origins can be traced back to a group of survivors who, in the wake of the apocalyptic event, refused to adopt the aggressive and militaristic ideologies of many other factions. Instead, they chose a path rooted in civilian protection, humanitarianism, and diplomacy.

The CDF's primary goal is to establish safe havens for ordinary people in the dangerous post-apocalyptic world. They believe in the power of community, cooperation, and diplomacy over aggression, seeking to build bridges with other factions rather than engage in conflicts. While they maintain a well-armed defensive force to protect their settlements, the CDF emphasizes negotiation, trade, and peaceful coexistence whenever possible.
    
The faction's settlements are often known for their hospitality, offering refuge to travelers and trade opportunities to nearby groups. The CDF values knowledge and education, and they have libraries and schools within their communities, striving to preserve pre-apocalyptic knowledge and culture. Despite their peaceful ideals, the CDF is not without its challenges, as their refusal to engage in aggressive expansion has led to tension with more power-hungry factions. Nonetheless, their unique approach and commitment to fostering cooperation make them a distinctive and fascinating faction in the "After the Flash" lore.
]]
CONTENT_CDF = CONTENT_CDF:gsub("\n", "<br>\n")

return
{
    {
        metadata = {
            author="Terra_Verbis",
            fileName="wiki_factions",
            title="Factions"
        },

        content = {
            ["Factions"] = HTML.PExpr(
                {"h2", {class="display-7"}, "Factions"},
                {"p", {}, CONTENT_FACTIONS}
            ),

            ["Civilian Defense Front"] = HTML.PExpr(
                {"h3", {class="display-15"}, "Civilian Defense Front"},
                {"p", {}, CONTENT_CDF}
            ),
        }
    },
}

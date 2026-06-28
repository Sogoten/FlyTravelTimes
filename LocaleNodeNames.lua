-- FlyTravelTimes Locale Node Name Mappings
-- Maps localized flight node names → English (used in FlightData.lua)
-- Auto-collected from live clients by Sogoten

FlyTravelTimes = FlyTravelTimes or {}
FlyTravelTimes.LocaleNodeNames = {}

-- German (deDE) → English
FlyTravelTimes.LocaleNodeNames["deDE"] = {
    -- Kalimdor
    ["Donnerfels, Mulgore"]                                  = "Thunder Bluff, Mulgore",
    ["Orgrimmar, Durotar"]                                   = "Orgrimmar, Durotar",
    ["Das Wegekreuz, Brachland"]                             = "Crossroads, The Barrens",
    ["Sonnenfels, Steinkrallengebirge"]                      = "Sun Rock Retreat, Stonetalon Mountains",
    ["Freiwindposten, Tausend Nadeln"]                       = "Freewind Post, Thousand Needles",
    ["Schattenflucht, Desolace"]                             = "Shadowprey Village, Desolace",
    ["Gadgetzan, Tanaris"]                                   = "Gadgetzan, Tanaris",
    ["Camp Mojache, Feralas"]                                = "Camp Mojache, Feralas",
    ["Valormok, Azshara"]                                    = "Valormok, Azshara",
    ["Blutgiftposten, Teufelswald"]                          = "Bloodvenom Post, Felwood",
    ["Ewige Warte, Winterquell"]                             = "Everlook, Winterspring",
    ["Brackenwall, Düstermarschen"]                          = "Brackenwall Village, Dustwallow Marsh",
    ["Außenposten von Zoram'gar, Eschental"]                 = "Zoram'gar Outpost, Ashenvale",
    ["Splitterholzposten, Eschental"]                        = "Splintertree Post, Ashenvale",
    ["Mondlichtung"]                                         = "Nighthaven, Moonglade",
    ["Burg Cenarius, Silithus"]                              = "Cenarion Hold, Silithus",
    ["Camp Taurajo, Brachland"]                              = "Camp Taurajo, The Barrens",
    ["Marschalls Zuflucht, Krater von Un'Goro"]              = "Marshal's Refuge, Un'Goro Crater",
    ["Ratschet, Brachland"]                                  = "Ratchet, The Barrens",
    ["Smaragdrefugium, Teufelswald"]                         = "Emerald Sanctuary, Felwood",
    ["Morastwinkel, Düstermarschen"]                         = "Mudsprocket, Dustwallow Marsh",
    -- Outland
    ["Thrallmar, Höllenfeuerhalbinsel"]                      = "Thrallmar, Hellfire Peninsula",
    ["Falkenwacht, Höllenfeuerhalbinsel"]                    = "Falcon Watch, Hellfire Peninsula",
    ["Zabra'jin, Zangarmarschen"]                            = "Zabra'jin, Zangarmarsh",
    ["Garadar, Nagrand"]                                     = "Garadar, Nagrand",
    ["Area 52, Nethersturm"]                                 = "Area 52, Netherstorm",
    ["Schattenmond, Schattenmondtal"]                        = "Shadowmoon Village, Shadowmoon Valley",
    ["Donnerfeste, Schergrat"]                               = "Thunderlord Stronghold, Blade's Edge Mountains",
    ["Steinbrecherfeste, Wälder von Terokkar"]               = "Stonebreaker Hold, Terokkar Forest",
    ["Shattrath, Wälder von Terokkar"]                       = "Shattrath, Terokkar Forest",
    ["Höllenfeuerhalbinsel, das Dunkle Portal, Horde"]       = "Hellfire Peninsula, The Dark Portal, Horde",
    ["Die Sturmsäule, Nethersturm"]                          = "The Stormspire, Netherstorm",
    ["Altar der Sha'tar, Schattenmondtal"]                   = "Altar of Sha'tar, Shadowmoon Valley",
    ["Rückenbrechergrat, Höllenfeuerhalbinsel"]              = "Spinebreaker Ridge, Hellfire Peninsula",
    ["Kosmozang, Nethersturm"]                               = "Cosmowrench, Netherstorm",
    ["Sumpfrattenposten, Zangarmarschen"]                    = "Swamprat Post, Zangarmarsh",
    ["Der ewige Hain, Schergrat"]                            = "Evergrove, Blade's Edge Mountains",
    ["Dorf der Mok'Nathal, Schergrat"]                       = "Mok'Nathal Village, Blade's Edge Mountains",
    -- Eastern Kingdoms
    ["Das Grabmal, Silberwald"]                              = "The Sepulcher, Silverpine Forest",
    ["Unterstadt, Tirisfal"]                                 = "Undercity, Tirisfal",
    ["Tarrens Mühle, Hügelland"]                             = "Tarren Mill, Hillsbrad",
    ["Hammerfall, Arathi"]                                   = "Hammerfall, Arathi",
    ["Beutebucht, Schlingendorntal"]                         = "Booty Bay, Stranglethorn",
    ["Grom'gol, Schlingendorntal"]                           = "Grom'gol, Stranglethorn",
    ["Kargath, Ödland"]                                      = "Kargath, Badlands",
    ["Steinard, Sümpfe des Elends"]                          = "Stonard, Swamp of Sorrows",
    ["Kapelle des hoffnungsvollen Lichts, Östliche Pestländer"] = "Light's Hope Chapel, Eastern Plaguelands",
    ["Flammenkamm, Brennende Steppe"]                        = "Flame Crest, Burning Steppes",
    ["Thoriumspitze, Sengende Schlucht"]                     = "Thorium Point, Searing Gorge",
    ["Dorf der Bruchhauer, Hinterland"]                      = "Revantusk Village, The Hinterlands",
    ["Silbermond"]                                           = "Silvermoon City",
    ["Tristessa, Geisterlande"]                              = "Tranquillien, Ghostlands",
    ["Zul'Aman, Geisterlande"]                               = "Zul'Aman",
}

-- French (frFR) → English
-- TODO: needs collection from frFR client
FlyTravelTimes.LocaleNodeNames["frFR"] = {
}

-- Translate a node name to English using the current locale mapping
function FlyTravelTimes:TranslateNodeName(name)
    if not name then return name end
    local locale = GetLocale()
    local map = FlyTravelTimes.LocaleNodeNames[locale]
    if map and map[name] then
        return map[name]
    end
    return name
end

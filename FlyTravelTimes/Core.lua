-- FlyTravelTimes Core
-- Shows a progress bar during flight paths

FlyTravelTimes = FlyTravelTimes or {}
local FTT = FlyTravelTimes

-- Saved variables
FlyTravelTimesDB = FlyTravelTimesDB or {
    enabled = true,
    showEstimate = true,
    barWidth = 300,
    barHeight = 30,
    posX = 0,
    posY = 200,
    barStyle = "classic", -- Default style
    fontSize = 13,        -- Font size for bar text
    barLocked = false,    -- Whether the bar is locked in place
}

-- Local variables
local flightStartTime = nil
local flightDuration = nil
local sourceNode = nil
local destNode = nil
local updateTimer = 0

-- Detect game version
local function GetGameVersion()
    local version, build, date, tocversion = GetBuildInfo()
    
    if tocversion >= 110000 then
        return "RETAIL"
    elseif tocversion >= 100000 then
        return "RETAIL" -- Dragonflight
    elseif tocversion >= 90000 then
        return "RETAIL" -- Shadowlands
    elseif tocversion >= 50000 then
        return "MOP" -- Mists of Pandaria Remix or Classic MoP
    elseif tocversion >= 40000 then
        return "CATA"
    elseif tocversion >= 30000 then
        return "WOTLK"
    elseif tocversion >= 20000 then
        return "TBC"
    else
        return "CLASSIC"
    end
end

-- Get player faction
local function GetPlayerFaction()
    local faction = UnitFactionGroup("player")
    -- UnitFactionGroup can return "Neutral" (e.g. unaligned Pandaren)
    -- or nil in rare cases. Default to "Alliance" as fallback.
    if faction ~= "Horde" and faction ~= "Alliance" then
        -- Try both factions when neutral - caller handles this
        return "Alliance"
    end
    return faction
end

-- Strip ", Zone Name" suffix from Retail taxi node names
-- e.g. "Thrallmar, Hellfire Peninsula" -> "Thrallmar"
local function StripZoneSuffix(name)
    if not name then return name end
    local stripped = name:match("^(.-)%s*,.*$")
    return stripped or name
end

-- Get flight time between two nodes BY NAME
function FTT:GetFlightTime(fromName, toName)
    local version = GetGameVersion()
    local faction = GetPlayerFaction()
    
    if not self.FlightDB or not self.FlightDB[version] then
        return nil
    end
    
    local versionDB = self.FlightDB[version]
    if not versionDB[faction] then
        return nil
    end
    
    -- Direct lookup by name
    if versionDB[faction][fromName] and versionDB[faction][fromName][toName] then
        return versionDB[faction][fromName][toName]
    end
    
    -- Try reverse
    if versionDB[faction][toName] and versionDB[faction][toName][fromName] then
        return versionDB[faction][toName][fromName]
    end

    -- Retail returns "NodeName, ZoneName" - try stripping the zone suffix
    local fromStripped = StripZoneSuffix(fromName)
    local toStripped = StripZoneSuffix(toName)

    if fromStripped ~= fromName or toStripped ~= toName then
        if versionDB[faction][fromStripped] and versionDB[faction][fromStripped][toStripped] then
            return versionDB[faction][fromStripped][toStripped]
        end
        -- Try reverse
        if versionDB[faction][toStripped] and versionDB[faction][toStripped][fromStripped] then
            return versionDB[faction][toStripped][fromStripped]
        end
    end

    return nil
end

-- Create the flight timer bar
local timerFrame = CreateFrame("Frame", "FlyTravelTimesFrame", UIParent)
timerFrame:SetSize(FlyTravelTimesDB.barWidth, FlyTravelTimesDB.barHeight)
timerFrame:SetPoint("CENTER", FlyTravelTimesDB.posX, FlyTravelTimesDB.posY)
timerFrame:Hide()

-- Apply font size to bar text and route label
local function ApplyFontSize(size)
    timerFrame.text:SetFont("Fonts\\FRIZQT__.TTF", size, "OUTLINE")
    timerFrame.routeLabel:SetFont("Fonts\\FRIZQT__.TTF", math.max(size - 2, 8), "OUTLINE")
end

-- Make it movable (respects lock state)
timerFrame:SetMovable(true)
timerFrame:EnableMouse(true)
timerFrame:RegisterForDrag("LeftButton")
timerFrame:SetScript("OnDragStart", function(self)
    if not FlyTravelTimesDB.barLocked then
        self:StartMoving()
    end
end)
timerFrame:SetScript("OnDragStop", function(self)
    self:StopMovingOrSizing()
    local point, _, _, x, y = self:GetPoint()
    FlyTravelTimesDB.posX = x
    FlyTravelTimesDB.posY = y
end)

-- Background
timerFrame.bg = timerFrame:CreateTexture(nil, "BACKGROUND")
timerFrame.bg:SetAllPoints()
timerFrame.bg:SetColorTexture(0, 0, 0, 0.8)

-- Border
timerFrame.border = timerFrame:CreateTexture(nil, "BORDER")
timerFrame.border:SetAllPoints()
timerFrame.border:SetColorTexture(0.3, 0.3, 0.3, 1)
timerFrame.border:SetPoint("TOPLEFT", 1, -1)
timerFrame.border:SetPoint("BOTTOMRIGHT", -1, 1)

-- Progress bar
timerFrame.bar = CreateFrame("StatusBar", nil, timerFrame)
timerFrame.bar:SetPoint("TOPLEFT", 4, -4)
timerFrame.bar:SetPoint("BOTTOMRIGHT", -4, 4)
timerFrame.bar:SetStatusBarTexture("Interface\\TargetingFrame\\UI-StatusBar")
timerFrame.bar:SetStatusBarColor(0.2, 0.6, 1.0)
timerFrame.bar:SetMinMaxValues(0, 100)
timerFrame.bar:SetValue(0)

-- Progress bar background
timerFrame.bar.bg = timerFrame.bar:CreateTexture(nil, "BACKGROUND")
timerFrame.bar.bg:SetAllPoints(timerFrame.bar)
timerFrame.bar.bg:SetColorTexture(0.1, 0.1, 0.1, 0.5)

-- Text overlay
timerFrame.text = timerFrame.bar:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
timerFrame.text:SetPoint("CENTER")
timerFrame.text:SetTextColor(1, 1, 1)

-- Route label (above bar)
timerFrame.routeLabel = timerFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
timerFrame.routeLabel:SetPoint("BOTTOM", timerFrame, "TOP", 0, 4)
timerFrame.routeLabel:SetTextColor(1, 1, 1)
timerFrame.routeLabel:SetFont("Fonts\\FRIZQT__.TTF", 11, "OUTLINE")

-- Spark effect
timerFrame.bar.spark = timerFrame.bar:CreateTexture(nil, "OVERLAY")
timerFrame.bar.spark:SetTexture("Interface\\CastingBar\\UI-CastingBar-Spark")
timerFrame.bar.spark:SetBlendMode("ADD")
timerFrame.bar.spark:SetSize(20, timerFrame.bar:GetHeight() * 2.5)

-- Format time as MM:SS
local function FormatTime(seconds)
    if not seconds then return "??:??" end
    local mins = math.floor(seconds / 60)
    local secs = math.floor(seconds % 60)
    return string.format("%d:%02d", mins, secs)
end

-- Start flight timer
function FTT:StartFlightTimer(duration, fromNode, toNode)
    if not FlyTravelTimesDB.enabled then return end
    
    flightStartTime = GetTime()
    flightDuration = duration
    sourceNode = fromNode
    destNode = toNode
    
    timerFrame.bar:SetMinMaxValues(0, duration)
    
    -- Set route label
    timerFrame.routeLabel:SetText(string.format("%s > %s", fromNode or "?", toNode or "?"))
    
    timerFrame:Show()
    
    if FlyTravelTimesDB.showEstimate then
        local L = FTT.L or {}
        print(string.format("|cff00ff00%s:|r %s", L["ADDON_NAME"] or "FlyTravelTimes", string.format(L["FLIGHT_TIME"] or "Estimated flight time: %s", FormatTime(duration))))
    end
end

-- Stop flight timer
function FTT:StopFlightTimer()
    flightStartTime = nil
    flightDuration = nil
    sourceNode = nil
    destNode = nil
    timerFrame:Hide()
end

-- Update the timer bar
timerFrame:SetScript("OnUpdate", function(self, elapsed)
    if not flightStartTime or not flightDuration then
        return
    end
    
    updateTimer = updateTimer + elapsed
    if updateTimer < 0.05 then return end
    updateTimer = 0
    
    local currentTime = GetTime()
    local elapsedTime = currentTime - flightStartTime
    local remaining = flightDuration - elapsedTime
    
    if remaining <= 0 then
        FTT:StopFlightTimer()
        return
    end
    
    -- Update bar
    self.bar:SetValue(elapsedTime)
    
    -- Update text
    local percentage = (elapsedTime / flightDuration) * 100
    local L = FTT.L or {}
    self.text:SetText(string.format(L["REMAINING"] or "%s remaining (%d%%)", FormatTime(remaining), percentage))
    
    -- Update spark position
    local progress = elapsedTime / flightDuration
    local width = self.bar:GetWidth()
    self.bar.spark:SetPoint("CENTER", self.bar, "LEFT", width * progress, 0)
end)

-- Hook into taxi system
local eventFrame = CreateFrame("Frame")
eventFrame:RegisterEvent("TAXIMAP_OPENED")
eventFrame:RegisterEvent("TAXIMAP_CLOSED")
eventFrame:RegisterEvent("PLAYER_CONTROL_LOST")
eventFrame:RegisterEvent("PLAYER_CONTROL_GAINED")
eventFrame:RegisterEvent("ADDON_LOADED")

local lastTaxiNodeName = nil
local selectedDestinationName = nil

-- Hook TakeTaxiNode to capture destination NAME
local originalTakeTaxiNode = TakeTaxiNode
function TakeTaxiNode(destinationSlot)
    if TaxiNodeName then
        selectedDestinationName = TaxiNodeName(destinationSlot)
    end
    return originalTakeTaxiNode(destinationSlot)
end

eventFrame:SetScript("OnEvent", function(self, event, ...)
    if event == "ADDON_LOADED" then
        local addonName = ...
        if addonName == "FlyTravelTimes" then
            local L = FTT.L or {}
            print(string.format("|cff00ff00%s|r %s", L["ADDON_NAME"] or "FlyTravelTimes", L["LOADED"] or "loaded! Use /ftt for options."))
            
            -- Apply saved bar style
            if FlyTravelTimesDB.barStyle and FTT.BarStyles then
                FTT.BarStyles:ApplyStyle(FlyTravelTimesDB.barStyle, timerFrame)
            end
            -- Apply saved font size
            ApplyFontSize(FlyTravelTimesDB.fontSize or 13)
        end
        
    elseif event == "TAXIMAP_OPENED" then
        -- Store the current node NAME when taxi map opens
        selectedDestinationName = nil
        lastTaxiNodeName = nil
        
        if NumTaxiNodes and TaxiNodeGetType and TaxiNodeName then
            local numNodes = NumTaxiNodes()
            for i = 1, numNodes do
                if TaxiNodeGetType(i) == "CURRENT" then
                    lastTaxiNodeName = TaxiNodeName(i)
                    break
                end
            end
        end
        
    elseif event == "PLAYER_CONTROL_LOST" then
        -- Check if we're on a flight path
        C_Timer.After(0.2, function()
            if UnitOnTaxi("player") and lastTaxiNodeName and selectedDestinationName then
                local duration = FTT:GetFlightTime(lastTaxiNodeName, selectedDestinationName)
                if duration then
                    FTT:StartFlightTimer(duration, lastTaxiNodeName, selectedDestinationName)
                else
                    -- Flight path not in database
                    local L = FTT.L or {}
                    if FlyTravelTimesDB.showEstimate then
                        local version = GetGameVersion()
                        local faction = GetPlayerFaction()
                        print(string.format("|cff00ff00%s:|r Flight path not in database [%s/%s]: %s -> %s",
                            L["ADDON_NAME"] or "FlyTravelTimes",
                            version, faction,
                            tostring(lastTaxiNodeName), tostring(selectedDestinationName)))
                    end
                end
                selectedDestinationName = nil
            end
        end)
        
    elseif event == "PLAYER_CONTROL_GAINED" then
        -- Flight ended
        if flightStartTime then
            FTT:StopFlightTimer()
        end
        selectedDestinationName = nil
        lastTaxiNodeName = nil
    end
end)

-- Hook taxi map tooltips to show flight times
if TaxiNodeOnButtonEnter then
    hooksecurefunc("TaxiNodeOnButtonEnter", function(button)
        if not button or not GameTooltip then return end
        
        local buttonID = button:GetID()
        if not buttonID or TaxiNodeGetType(buttonID) ~= "REACHABLE" then
            return
        end
        
        -- Get current node name
        local fromName = lastTaxiNodeName
        if not fromName and NumTaxiNodes and TaxiNodeGetType and TaxiNodeName then
            local numNodes = NumTaxiNodes()
            for i = 1, numNodes do
                if TaxiNodeGetType(i) == "CURRENT" then
                    fromName = TaxiNodeName(i)
                    break
                end
            end
        end
        
        -- Get destination node name
        local toName = TaxiNodeName and TaxiNodeName(buttonID)
        
        if fromName and toName then
            local duration = FTT:GetFlightTime(fromName, toName)
            if duration then
                -- Add flight time to tooltip with clock icon
                GameTooltip:AddLine(string.format("|TInterface\\Icons\\INV_Misc_PocketWatch_02:16|t %s", FormatTime(duration)), 1, 1, 1)
                GameTooltip:Show()
            end
        end
    end)
end

-- Slash commands
SLASH_FLYTRAVELTIMES1 = "/ftt"
SLASH_FLYTRAVELTIMES2 = "/flytraveltimes"

SlashCmdList["FLYTRAVELTIMES"] = function(msg)
    msg = string.lower(msg or "")
    local L = FTT.L or {}
    
    -- Handle "style" commands
    if msg:match("^style") then
        local styleName = msg:match("^style%s+(.+)")
        
        if styleName == "list" then
            -- Show all available styles
            print(string.format("|cff00ff00%s|r Available bar styles:", L["ADDON_NAME"] or "FlyTravelTimes"))
            local styles = FTT.BarStyles:GetStyleList()
            for _, style in ipairs(styles) do
                local current = (FlyTravelTimesDB.barStyle == style.key) and " |cff00ff00(current)|r" or ""
                print(string.format("  |cffFFD700%s|r - %s%s", style.name, style.description, current))
                print(string.format("    Usage: /ftt style %s", style.key))
            end
            return
            
        elseif styleName then
            -- Apply a style
            if FTT.BarStyles.styles[styleName] then
                FlyTravelTimesDB.barStyle = styleName
                FTT.BarStyles:ApplyStyle(styleName, timerFrame)
                local styleDef = FTT.BarStyles.styles[styleName]
                print(string.format("|cff00ff00%s:|r Bar style changed to |cffFFD700%s|r", L["ADDON_NAME"] or "FlyTravelTimes", styleDef.name))
            else
                print(string.format("|cff00ff00%s:|r Unknown style '%s'. Use /ftt style list to see all styles.", L["ADDON_NAME"] or "FlyTravelTimes", styleName))
            end
            return
        else
            print(string.format("|cff00ff00%s:|r Usage: /ftt style <name> or /ftt style list", L["ADDON_NAME"] or "FlyTravelTimes"))
            return
        end
    end
    
    if msg == "toggle" then
        FlyTravelTimesDB.enabled = not FlyTravelTimesDB.enabled
        print(string.format("|cff00ff00%s:|r %s", 
            L["ADDON_NAME"] or "FlyTravelTimes",
            FlyTravelTimesDB.enabled and (L["ENABLED"] or "Enabled") or (L["DISABLED"] or "Disabled")))
            
    elseif msg == "estimate" then
        FlyTravelTimesDB.showEstimate = not FlyTravelTimesDB.showEstimate
        print(string.format("|cff00ff00%s:|r %s", 
            L["ADDON_NAME"] or "FlyTravelTimes",
            FlyTravelTimesDB.showEstimate and (L["ESTIMATE_ON"] or "Estimate messages enabled") or (L["ESTIMATE_OFF"] or "Estimate messages disabled")))
            
    elseif msg == "test" then
        FTT:StartFlightTimer(120, "Test Location A", "Test Location B")
        print(string.format("|cff00ff00%s:|r %s", L["ADDON_NAME"] or "FlyTravelTimes", L["TESTING"] or "Testing 2 minute flight"))
        
    elseif msg == "reset" then
        timerFrame:ClearAllPoints()
        timerFrame:SetPoint("CENTER", 0, 200)
        FlyTravelTimesDB.posX = 0
        FlyTravelTimesDB.posY = 200
        print(string.format("|cff00ff00%s:|r %s", L["ADDON_NAME"] or "FlyTravelTimes", L["POSITION_RESET"] or "Position reset"))
        
    elseif msg == "lock" then
        FlyTravelTimesDB.barLocked = not FlyTravelTimesDB.barLocked
        local statusMsg = FlyTravelTimesDB.barLocked and (L["BAR_LOCKED"] or "Bar locked") or (L["BAR_UNLOCKED"] or "Bar unlocked")
        print(string.format("|cff00ff00%s:|r %s", L["ADDON_NAME"] or "FlyTravelTimes", statusMsg))

    elseif msg:match("^fontsize") then
        local sizeStr = msg:match("^fontsize%s+(%d+)")
        if sizeStr then
            local size = tonumber(sizeStr)
            if size and size >= 6 and size <= 32 then
                FlyTravelTimesDB.fontSize = size
                ApplyFontSize(size)
                print(string.format("|cff00ff00%s:|r %s", L["ADDON_NAME"] or "FlyTravelTimes",
                    string.format(L["FONT_SIZE_SET"] or "Font size set to %d", size)))
            else
                print(string.format("|cff00ff00%s:|r %s", L["ADDON_NAME"] or "FlyTravelTimes",
                    L["FONT_SIZE_RANGE"] or "Font size must be between 6 and 32"))
            end
        else
            print(string.format("|cff00ff00%s:|r %s", L["ADDON_NAME"] or "FlyTravelTimes",
                string.format(L["FONT_SIZE_CURRENT"] or "Current font size: %d. Usage: /ftt fontsize <6-32>", FlyTravelTimesDB.fontSize or 13)))
        end

    else
        print(string.format("|cff00ff00%s|r %s", L["ADDON_NAME"] or "FlyTravelTimes", L["CMD_HEADER"] or "commands:"))
        print("  " .. (L["CMD_TOGGLE"] or "/ftt toggle - Enable/disable addon"))
        print("  " .. (L["CMD_ESTIMATE"] or "/ftt estimate - Toggle estimate messages"))
        print("  " .. (L["CMD_TEST"] or "/ftt test - Test the timer bar"))
        print("  " .. (L["CMD_RESET"] or "/ftt reset - Reset bar position"))
        print("  " .. (L["CMD_LOCK"] or "/ftt lock - Lock/unlock the bar position"))
        print("  " .. (L["CMD_FONTSIZE"] or "/ftt fontsize <6-32> - Set font size"))
        print("  /ftt style <name> - Change bar style")
        print("  /ftt style list - Show all available styles")
        print("  " .. (L["CMD_HELP"] or "Drag the bar to move it"))
    end
end

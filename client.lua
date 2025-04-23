-- Configuratie
local config = {
    toggleKey = 20 -- Standaard Z-toets (keycode 20)
}

local disPlayerNames = 20
local playerDistances = {}
local showIDs = false -- Variabele om bij te houden of ID's getoond moeten worden

local function DrawText3D(position, text, r, g, b)
    local onScreen, _x, _y = World3dToScreen2d(position.x, position.y, position.z + 1)
    local dist = #(GetGameplayCamCoords() - position)

    local scale = (1 / dist) * 2
    local fov = (1 / GetGameplayCamFov()) * 100
    local scale = scale * fov

    if onScreen then
        if not useCustomScale then
            SetTextScale(0.0 * scale, 0.55 * scale)
        else
            SetTextScale(0.0 * scale, customScale)
        end
        SetTextFont(0)
        SetTextProportional(1)
        SetTextColour(r, g, b, 255)
        SetTextDropshadow(0, 0, 0, 0, 255)
        SetTextEdge(2, 0, 0, 0, 150)
        SetTextDropShadow()
        SetTextOutline()
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(_x, _y)
    end
end

Citizen.CreateThread(function()
    Wait(500)
    while true do
        if showIDs then -- Alleen ID's tonen als showIDs true is
            for _, id in ipairs(GetActivePlayers()) do
                local targetPed = GetPlayerPed(id)
                local targetPedCords = GetEntityCoords(targetPed)
                if playerDistances[id] and playerDistances[id] < disPlayerNames then
                    if NetworkIsPlayerTalking(id) then
                        DrawText3D(targetPedCords, GetPlayerServerId(id), 247, 124, 24)
                        DrawMarker(27, targetPedCords.x, targetPedCords.y, targetPedCords.z - 0.97, 0, 0, 0, 0, 0, 0, 1.001, 1.0001, 0.5001, 173, 216, 230, 100, 0, 0, 0, 0)
                    else
                        DrawText3D(targetPedCords, GetPlayerServerId(id), 255, 255, 255)
                    end
                end
            end

            -- Toon ook het ID van de speler zelf
            local playerPed = PlayerPedId()
            local playerCoords = GetEntityCoords(playerPed)
            DrawText3D(playerCoords, GetPlayerServerId(PlayerId()), 255, 255, 255) -- Maak de kleur wit
        end
        Citizen.Wait(0)
    end
end)

Citizen.CreateThread(function()
    while true do
        local playerPed = PlayerPedId()
        local playerCoords = GetEntityCoords(playerPed)

        for _, id in ipairs(GetActivePlayers()) do
            local targetPed = GetPlayerPed(id)
            if targetPed ~= playerPed then
                local distance = #(playerCoords - GetEntityCoords(targetPed))
                playerDistances[id] = distance
            end
        end
        Wait(1000)
    end
end)

-- Controleer op de ingestelde toets
Citizen.CreateThread(function()
    while true do
        if IsControlPressed(0, config.toggleKey) then -- Gebruik de toets uit de configuratie
            showIDs = true -- Zet tonen van ID's aan
        else
            showIDs = false -- Zet tonen van ID's uit
        end
        Citizen.Wait(0)
    end
end)
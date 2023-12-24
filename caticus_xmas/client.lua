local xmasTreeCoords = vector3(154.25, -982.7, 30.09)
local xmasTree = nil
local hasClaimed = false
local Framework = nil

if Config and Config.Framework == 'esx' then
    TriggerEvent('esx:getSharedObject', function(obj) Framework = obj end)
elseif Config and Config.Framework == 'qbcore' then
    Framework = QBCore
end

function ShowNotification(message)
    if Config.Framework == 'esx' and Framework then
        Framework.ShowNotification(message)
    elseif Config.Framework == 'qbcore' and Framework then
        Framework.Functions.Notify(message, "primary", 5000)
    else
        SetNotificationTextEntry("STRING")
        AddTextComponentSubstringPlayerName(message)
        DrawNotification(false, true)
    end
end

Citizen.CreateThread(function()
    xmasTree = CreateObject(GetHashKey("prop_xmas_tree_int"), 154.25, -982.7, 29.09, false, false, true)

    while true do
        Citizen.Wait(0)
        local playerCoords = GetEntityCoords(PlayerPedId())
        local dist = #(playerCoords - xmasTreeCoords)

        if dist < 5.0 then
            DrawText3D(xmasTreeCoords.x, xmasTreeCoords.y, xmasTreeCoords.z - 0.3, "Press ~b~[~g~E~b~]~w~ to claim")

            if IsControlJustReleased(0, 38) and dist < 3.0 then 
                if not hasClaimed then
                    TriggerServerEvent('caticus_xmas:giveRandomGift')
                    hasClaimed = true
                    ShowNotification("You've claimed your gift!")
                else
                    ShowNotification("You've already claimed your gift.")
                end
            end
        end
    end
end)

function DrawText3D(x, y, z, text)
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(x, y, z, 0)
    DrawText(0.0, 0.0)
    ClearDrawOrigin()
end

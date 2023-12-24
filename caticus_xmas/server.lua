if Config.framework == 'esx' then
    ESX = nil
    TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
elseif Config.framework == 'qbcore' then
    QBCore = exports['qb-core']:GetCoreObject()
end

RegisterServerEvent('caticus_xmas:giveRandomGift')
AddEventHandler('caticus_xmas:giveRandomGift', function()
    local src = source
    if Config.Framework == 'esx' and ESX then
        local xPlayer = ESX.GetPlayerFromId(src)
        if xPlayer then
            local gift = Config.Gifts[math.random(#Config.Gifts)]
            xPlayer.addInventoryItem(gift, 1)
            TriggerClientEvent('esx:showNotification', src, 'You have received a ' .. gift)
        end
    elseif Config.Framework == 'qbcore' and QBCore then
        local Player = QBCore.Functions.GetPlayer(src)
        if Player then
            local gift = Config.Gifts[math.random(#Config.Gifts)]
            Player.Functions.AddItem(gift, 1)
            TriggerClientEvent('QBCore:Notify', src, 'You have received a ' .. gift, 'success')
        end
    end
end)
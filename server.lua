ESX = exports["es_extended"]:getSharedObject()

ESX.RegisterServerCallback('esx_phoneladen:buyPhone', function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)

    if xPlayer.getMoney() >= Config.PhonePrice then
        xPlayer.removeMoney(Config.PhonePrice)
        xPlayer.addInventoryItem(Config.PhoneItem, 1)
        cb(true)
    else
        cb(false)
    end
end)

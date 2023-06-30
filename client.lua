ESX = exports["es_extended"]:getSharedObject()

Citizen.CreateThread(function()
    local hash = GetHashKey(Config.Ped.model)
    while not HasModelLoaded(hash) do
        RequestModel(hash)
        Wait(20)
    end

    ped = CreatePed("PED_TYPE_CIVMALE", Config.Ped.model, Config.Ped.coords, Config.Ped.heading, false, true)
    SetBlockingOfNonTemporaryEvents(ped, true)
    FreezeEntityPosition(ped, true)
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        local playerCoords = GetEntityCoords(PlayerPedId())
        local pedCoords = GetEntityCoords(ped)
        local dist = #(playerCoords - pedCoords)

        if dist < 2 then
            ESX.ShowHelpNotification('Drücke ~INPUT_CONTEXT~ um ein Telefon zu kaufen')

            if IsControlJustReleased(0, 38) then -- Taste "E"
                ESX.TriggerServerCallback('esx_phoneladen:buyPhone', function(bought)
                    if bought then
                        ESX.ShowNotification('Du hast ein Telefon gekauft!')
                    else
                        ESX.ShowNotification('Du hast nicht genug Geld!')
                    end
                end)
            end
        else
            Citizen.Wait(500)
        end
    end
end)

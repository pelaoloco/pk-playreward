ESX = exports["es_extended"]:getSharedObject()

AddEventHandler('onResourceStart', function(resourceName)
    if (GetCurrentResourceName() ~= resourceName) then
      return
    end
    print('Gracias por utilizar mi script, te invito a mi discord para conocer sobre otros scripts.')
    print('discord.gg/SyfSquKefU')
  end)
  
function GetRandomNumber(min, max)
    math.randomseed(GetGameTimer())
    return math.random(min, max)
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(Config.TiempoEntrega * 60000) 
        local players = ESX.GetPlayers()
        for i=1, #players do
            local xPlayer = ESX.GetPlayerFromId(players[i])
            local stim = GetPlayerName(players[i])

            if xPlayer ~= nil then
                local cantidadDinero = GetRandomNumber(Config.MinCantidadDinero, Config.MaxCantidadDinero)
                local cantidadItem = GetRandomNumber(Config.MinCantidad, Config.MaxCantidad)
                local itemRecompensa = Config.ItemsEntrega[math.random(1, #Config.ItemsEntrega)]
                xPlayer.addMoney(cantidadDinero)
                exports.ox_inventory:AddItem(1, itemRecompensa, cantidadItem)
                DiscordLog('PK SCRIPTS', 'Playtime Reward', 'El jugador **'..stim..'** ha recibido su recompensa por el tiempo de juego! \n Dinero: **'..cantidadDinero..'** \n Item: **'..itemRecompensa..'** \n Cantidad de item: **'..cantidadItem..'**', 'pelaoloko')
            end
        end
    end
end)

function DiscordLog(autor, title, message, futer)
    local webHook = ''
    local embedData = {{
        ['title'] = title,
        ['color'] = 16711680,
        ['footer'] = {
            ['text'] = futer .. ' | ' .. os.date("%d/%m/%Y %X %p")
        },
        ['description'] = message,
        ['author'] = {
            ['name'] = autor
        }
    }}
    PerformHttpRequest(webHook, nil, 'POST', json.encode({
        username = 'pelaoloko',
        embeds = embedData
    }), {
        ['Content-Type'] = 'application/json'
    })
end

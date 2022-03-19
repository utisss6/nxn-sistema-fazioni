ESX = exports.es_extended:getSharedObject()
Citizen.CreateThread(function()
    Wait(250)
    for k,v in pairs(Fazioni) do 
        TriggerEvent('gridsystem:registerMarker', {
            name = 'inventario'..k,
            pos = v.inv,
            scale = vector3(1.0, 1.0, 1.0),
            size = vector3(1.0, 1.0, 1.0),
            drawDistance = 0.0,
            msg = '~b~[E] ~w~Inventario',
            control = 'E',
            permission = k,
            show3D = true,
            action = function()
                exports.ox_inventory:openInventory('stash', k)
            end
        })
        -- boss menu
        TriggerEvent('gridsystem:registerMarker', {
            name = 'bossmenu'..k,
            pos = v.boss,
            scale = vector3(1.0, 1.0, 1.0),
            size = vector3(1.0, 1.0, 1.0),
            drawDistance = 0.0,
            msg = '~b~[E] ~w~Boss menù',
            control = 'E',
            permission = k,
            show3D = true,
            action = function()
                TriggerEvent("esx_society:openBossMenu")
            end
        })
        -- CAMERINO 
        TriggerEvent('gridsystem:registerMarker', {
            name = 'camerino'..k,
            pos = v.camerino,
            scale = vector3(1.5, 1.5, 1.5),
            size = vector3(1.5, 1.5, 1.5),
            drawDistance = 0.0,
            msg = '~b~[E] ~w~Camerino',
            control = 'E',
            show3D = true,
            permission = k,
            action = function()
                NXN_camerino()
            end,
			onExit = function()
				ESX.UI.Menu.CloseAll()
			end
        })
        -- GARAGE
        TriggerEvent('gridsystem:registerMarker', {
            name = 'garage'..k,
            pos = v.garage.pos,
            size = vector3(5.0, 5.0, 5.0),
            scale = vector3(1.5, 1.5, 1.5),
            drawDistance = 7.0,
            msg = '~b~[E] ~w~Garage',
            type = 36,
            color = { r = 0, g = 99, b = 130 },
            control = 'E',
            permission = k,
            action = function()
                ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'max', {
                    title = 'SELEZIONA CATEGORIA',
                    align = 'right',
                    elements = {
                        {label = 'Prendi Veicolo', value = 'prendi'},
                        {label = 'Deposita Veicolo', value = 'lascia'}
                    }
                },     function(data, menu)
                        local verifica = data.current.value
                    
                        if verifica == 'prendi' then
                            ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'utis', {
                                title = 'SELEZIONA VEICOLO',
                                align = 'right',
                                elements = v.garage.auto
                            },     function(data, menu)
                                    local verifica = data.current.value	                    
                                        TriggerEvent('nxn:deleteVehicle', 1)
                                        ESX.Game.SpawnVehicle(data.current.value, v.garage.pos, 224.0, function(vehicle)
                                            SetPedIntoVehicle(GetPlayerPed(-1),vehicle,-1)
                                        end)
                                    menu.close()
                                end, 
                                function(data, menu)
                                    menu.close()
                                end
                            )
                        elseif verifica == 'lascia' then
                            local veh = GetVehiclePedIsIn(PlayerPedId(), false)
                            DeleteEntity(veh)
                        end
                            Wait(500)
                        end, 
                    function(data, menu)
                           menu.close()
                    end
                )
            

            end,
			onExit = function()
				ESX.UI.Menu.CloseAll()
			end
        })
        -- DUTY
        TriggerEvent('gridsystem:registerMarker', {
            name = 'duty'..k,
            pos = v.duty,
            scale = vector3(1.5, 1.5, 1.5),
            size = vector3(1.5, 1.5, 1.5),
            drawDistance = 0.0,
            msg = '~b~[E] ~w~Servizio',
            control = 'E',
            show3D = true,  ----- coglione non mettere permission senno' l'ff non lo vede! hahahh
            action = function()
                if   ESX.PlayerData.job.name == k or ESX.PlayerData.job.name == "off"..k then
                NXN_Duty()
                else 
                    ESX.ShowNotification("Non hai il permesso")
                end

            end,
			onExit = function()
				ESX.UI.Menu.CloseAll()
			end
        })
    end 
end)

Citizen.CreateThread(function()
    for k,max in pairs(Personali) do 
        TriggerEvent('gridsystem:registerMarker', {
            name = 'personale'..k,
            pos = max.inv,
            scale = vector3(1.5, 1.5, 1.5),
            size = vector3(1.5, 1.5, 1.5),
            drawDistance = 0.0,
            msg = '~b~[E] ~w~Inventario Personale di '..k,
            control = 'E',
            show3D = true,
            action = function()
                if ESX.PlayerData.identifier == max.hex then
                exports.ox_inventory:openInventory('stash', k)
               else
                ESX.ShowNotification('Non sei '..k)
               end
            end,
			onExit = function()
			
			end
        })
        TriggerEvent('gridsystem:registerMarker', {
            name = 'camerino'..k,
            pos = max.camerino,
            scale = vector3(1.5, 1.5, 1.5),
            size = vector3(1.5, 1.5, 1.5),
            drawDistance = 0.0,
            msg = '~b~[E] ~w~Camerino',
            control = 'E',
            show3D = true,
            action = function()
                NXN_camerino()
            end,
			onExit = function()
				ESX.UI.Menu.CloseAll()
			end
        })
    end
end)


function NXN_Duty()
    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'utiscoglione', {
        title = 'ENTRA/ESCI Servizio',
        align = 'top-left',
        elements = {
            {label = 'Entra in Servizio', value = 'in'},
            {label = 'Esci dal Servizio', value = 'out'}
        }
    },     function(data, menu)
            local verifica = data.current.value
            if verifica == 'in' then
                TriggerServerEvent("nxn:onduty")
            elseif verifica == "out" then
                TriggerServerEvent("nxn:offduty")
            end
        end, 
        function(data, menu)
               menu.close()
        end
    )
end

NXN_camerino = function()
    local elements = {}
  
    table.insert(elements, {label = 'Cambia Vestiti - Camerino', value = 'player_dressing'})
    table.insert(elements, {label = 'Cancella Outfit - Camerino', value = 'suppr_cloth'})
  
    ESX.UI.Menu.CloseAll()
  
    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'shop_main', {
        title    = 'Benvenuto ! Cosa vorresti fare ?',
        align    = 'top-right',
        elements = elements,
      }, function(data, menu)
      menu.close()
  
       
        if data.current.value == 'player_dressing' then
          
            ESX.TriggerServerCallback('esx_eden_clotheshop:getPlayerDressing', function(dressing)
                local elements = {}
  
                for i=1, #dressing, 1 do
                  table.insert(elements, {label = dressing[i], value = i})
                end
  
                ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'player_dressing', {
                    title    = 'Cambia Vestiti - Camerino',
                    align    = 'top-right',
                    elements = elements,
                    }, function(data, menu)
                        TriggerEvent('skinchanger:getSkin', function(skin)
                            ESX.TriggerServerCallback('esx_eden_clotheshop:getPlayerOutfit', function(clothes)
                                TriggerEvent('skinchanger:loadClothes', skin, clothes)
                                TriggerEvent('esx_skin:setLastSkin', skin)
                                TriggerEvent('skinchanger:getSkin', function(skin)
                                TriggerServerEvent('esx_skin:save', skin)
                            end)
                            ESX.ShowNotification('Hai indossato l\'outfit, grazie per la visita !')
                        end, data.current.value)
                    end)
                    end, function(data, menu)
                        menu.close()
                end)
            end)
        end
        if data.current.value == 'suppr_cloth' then
            ESX.TriggerServerCallback('esx_eden_clotheshop:getPlayerDressing', function(dressing)
                local elements = {}
                for i=1, #dressing, 1 do
                    table.insert(elements, {label = dressing[i], value = i})
                end
                ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'supprime_cloth', {
                  title    = 'Cancella Outfit - Camerino',
                  align    = 'top-right',
                  elements = elements,
                }, function(data, menu)
                    menu.close()
                TriggerServerEvent('esx_eden_clotheshop:deleteOutfit', data.current.value)                    
                    ESX.ShowNotification('Eliminato') 
                end, function(data, menu)
                    menu.close()              
                end)
            end)
        end
    end, function(data, menu)
        menu.close()
    end)
end


  -- DA utisss.#0672 & Maxday69#2257 CON AMORE :) 
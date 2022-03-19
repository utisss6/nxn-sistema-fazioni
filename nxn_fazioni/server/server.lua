-- OFF...
RegisterNetEvent("nxn:onduty")
AddEventHandler("nxn:onduty", function()
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    local job = xPlayer.job.name
    local grade = xPlayer.job.grade
    inservizio = string.gsub(job, "off", "")
    xPlayer.setJob(inservizio, grade)
    xPlayer.showNotification("Sei entrato in sevizio")
end)

RegisterNetEvent("nxn:offduty")
AddEventHandler("nxn:offduty", function()
    local xPlayer = ESX.GetPlayerFromId(source)
    local job = xPlayer.job.name
    local grade = xPlayer.job.grade
    xPlayer.setJob("off"..job, grade)
    xPlayer.showNotification("Sei uscito di servizio")
end)

-- INVENTARI
local ox_inventory = exports.ox_inventory

-- FAZIONI
AddEventHandler('onServerResourceStart', function(resourceName)
	if resourceName == 'ox_inventory' or resourceName == GetCurrentResourceName() then
		for k,v in pairs(Fazioni) do
			ox_inventory:RegisterStash(k,"NXN", 75, 200000, false, k)
		end
	end
end)

-- CASE
AddEventHandler('onServerResourceStart', function(resourceName)
	if resourceName == 'ox_inventory' or resourceName == GetCurrentResourceName() then
		for k,v in pairs(Personali) do
			ox_inventory:RegisterStash(k,"NXN INVENTARIO PERSONALE", 75, 200000, false)
		end
	end
end)


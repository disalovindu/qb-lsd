QBCore = nil
local QBCore = exports['qb-core']:GetCoreObject()

TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)

RegisterServerEvent('qb-lsd:filledBottles') --hero
AddEventHandler('qb-lsd:filledBottles', function()
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)
	if Player.Functions.GetItemByName('empty_bottle') then
	    if 	TriggerClientEvent("QBCore:Notify", src, "You Got Some Acid.", "Success", 8000) then
		  Player.Functions.AddItem('acid_bottle', 1) ---- change this shit 
		  Player.Functions.RemoveItem('empty_bottle', 1)
		  TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['acid_bottle'], "add")
		  TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['empty_bottle'], "remove")
	    end
	else
		TriggerClientEvent('QBCore:Notify', src, 'You don\'t have Empty Bottles', "error")
	end
end)

RegisterServerEvent('qb-lsd:makelsd')
AddEventHandler('qb-lsd:makelsd', function()
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)

	if Player.Functions.GetItemByName('acid_bottle') then
		Player.Functions.RemoveItem('acid_bottle', 1)----change this
		Player.Functions.AddItem('lsd', 1)----change this
		TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['acid_bottle'], "remove")
		TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['lsd'], "add")
		TriggerClientEvent('QBCore:Notify', src, 'LSD Made successfully', "success")
	else
		TriggerClientEvent('QBCore:Notify', src, 'You don\'t have the right items', "error") 
	end
end)

--sellsdrug ok

RegisterServerEvent('qb-lsd:selld')
AddEventHandler('qb-lsd:selld', function()
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)
	local Item = Player.Functions.GetItemByName('lsd')  
	for i = 1, Item.amount do
		if Item.amount >0 then
			if Player.Functions.GetItemByName('lsd') then
				Player.Functions.RemoveItem('lsd', 1)----change this
				TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['lsd'], "remove")
				Player.Functions.AddMoney("cash", Config.Pricesell, "sold-pawn-items")
				TriggerClientEvent('QBCore:Notify', src, 'You Sold LSD', "success")   
			else
				TriggerClientEvent('QBCore:Notify', src, 'You don\'t have the right items', "error") 
			end
		else
			TriggerClientEvent('QBCore:Notify', src, 'You don\'t have the right items', "error") 
		end
	end
end)



function CancelProcessing(playerId)
	if playersProcessingCannabis[playerId] then
		ClearTimeout(playersProcessingCannabis[playerId])
		playersProcessingCannabis[playerId] = nil
	end
end

RegisterServerEvent('qb-lsd:cancelProcessing2')
AddEventHandler('qb-lsd:cancelProcessing2', function()
	CancelProcessing(source)
end)

AddEventHandler('QBCore_:playerDropped', function(playerId, reason)
	CancelProcessing(playerId)
end)

RegisterServerEvent('qb-lsd:onPlayerDeath2')
AddEventHandler('qb-lsd:onPlayerDeath2', function(data)
	local src = source
	CancelProcessing(src)
end)

QBCore.Functions.CreateCallback('poppy:process', function(source, cb)
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)
	 
	if Player.PlayerData.item ~= nil and next(Player.PlayerData.items) ~= nil then
		for k, v in pairs(Player.PlayerData.items) do
		    if Player.Playerdata.items[k] ~= nil then
				if Player.Playerdata.items[k].name == "bag_cocke" then
					cb(true)
			    else
					TriggerClientEvent("QBCore:Notify", src, "You do not have any Coke process", "error", 10000)
					cb(false)
				end
	        end
		end	
	end
end)

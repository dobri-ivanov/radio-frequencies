ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end

	ESX.PlayerData = ESX.GetPlayerData()
    Refresh()
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job
    Refresh()
end)

--------------------------- Configuration ---------------------------
function Refresh()
    if ESX.PlayerData.job.name == 'police' then
        exports['rp-radio']:GivePlayerAccessToFrequencies(1, 2, 3, 4)                  --Locked frequencies for police
        exports['rp-radio']:RemovePlayerAccessToFrequencies(5, 6)  
    elseif ESX.PlayerData.job.name == 'ambulance' then
        exports['rp-radio']:GivePlayerAccessToFrequencies(4)                           --Locked frequencies for ambulance
        exports['rp-radio']:RemovePlayerAccessToFrequencies(1, 2, 3, 5, 6)
    elseif ESX.PlayerData.job.name == 'mechanic' then
        exports['rp-radio']:GivePlayerAccessToFrequencies(5)                           --Locked frequencies for mechanic
        exports['rp-radio']:RemovePlayerAccessToFrequencies(1, 2, 3, 4, 6)
    elseif ESX.PlayerData.job.name == 'taxi' then
        exports['rp-radio']:GivePlayerAccessToFrequencies(6)                           --Locked frequencies for taxi
        exports['rp-radio']:RemovePlayerAccessToFrequencies(1, 2, 3, 4, 5) 
    else
        Citizen.Wait(1000)
        exports['rp-radio']:RemovePlayerAccessToFrequencies(1, 2, 3, 4, 5, 6)          --All locked frequencies
    end
end

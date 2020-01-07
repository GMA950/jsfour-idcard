local Keys = {
	["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57, 
	["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177, 
	["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
	["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
	["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
	["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70, 
	["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
	["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
	["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}

ESX = nil

local open = false
--local LAurl = exports["mugshot"]:getMugshotUrl(GetPlayerPed(-1))
--local headshot
--local test

--print(headshot)

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

-- Open ID card
RegisterNetEvent('jsfour-idcard:open')
AddEventHandler('jsfour-idcard:open', function( data, type)
	open = true
	--headshot = mugstr
	--print(headshot)
	--fotografia(mugstr)
	SendNUIMessage({
		action = "open",
		array  = data,
		type   = type
	})
	
	--TriggerEvent("fotografia", mugstr)
end)

RegisterNetEvent('jsfour-idcard:shot')
AddEventHandler('jsfour-idcard:shot', function(playerID)
	local playerPed = GetPlayerPed(GetPlayerFromServerId( playerID ))
	--print(playerPed)
	--local handle = RegisterPedheadshotTransparent(playerPed)
	local handle = RegisterPedheadshot(playerPed)

	if not IsPedheadshotValid(handle) then
		print('hay un error aqui')
		print(handle)
	end

	while not IsPedheadshotReady (handle) do
		Wait (100)
		--print('test1')
	end
	local headshot = GetPedheadshotTxdString (handle)
	while open do
		--print('test2')
		Wait (5)
		DrawSprite (headshot, headshot, 0.777, 0.26, 0.07, 0.14, 0.0, 255, 255, 255, 1000)
	end
	if not open then
		UnregisterPedheadshot(handle)
	end
end)

-- Key events
Citizen.CreateThread(function()
	while true do 
		Wait(0)
		if IsControlJustReleased(0, Keys['F5']) and not open then
			openMenu()
		end
		if IsControlJustReleased(0, Keys['ESC']) and open or IsControlJustReleased(0, Keys['BACKSPACE']) and open or IsControlJustReleased(0, Keys['F5']) and open then --ESC OR BACKSPACE
			SendNUIMessage({
				action = "close"
			})
			open = false
		end
	end
end)

function openMenu()
	--
	--local mugshot, mugshotStr = ESX.Game.GetPedMugshot(GetPlayerPed(-1))
	--test = mugshot
	--SetEntityAsMissionEntity (GetPlayerPed (-1))
	--local PED_ID = NetworkGetNetworkIdFromEntity (GetPlayerPed (-1))
	--print(PED_ID)
	--
	ESX.UI.Menu.Open(
	  'default', GetCurrentResourceName(), 'id_card_menu', {
		  --title    = 'ID menu',
		  tittle   = 'Tus Documentos',
		  align    = 'top-left',
		  elements = {
			  {label = 'Revisa tu ID', value = 'checkID'},
			  {label = 'Muestra tu ID', value = 'showID'},
			  {label = 'Revisa tu Licencia de Conducir', value = 'checkDriver'},
			  {label = 'Muestra tu Licencia de Conducir', value = 'showDriver'},
			  {label = 'Revisa tu Licencia de Porte de Armas', value = 'checkFirearms'},
			  {label = 'Muestra tu Licencia de Porte de Armas', value = 'showFirearms'},
		  }
	  },
	  function(data, menu)
		  local val = data.current.value
		  
		  if val == 'checkID' then
			  TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(PlayerId()))
		  elseif val == 'checkDriver' then
			  TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(PlayerId()), 'driver')
		  elseif val == 'checkFirearms' then
			  TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(PlayerId()), 'weapon')
		  else
			  local player, distance = ESX.Game.GetClosestPlayer()
			  
			  if distance ~= -1 and distance <= 3.0 then
				  if val == 'showID' then
				  	TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(player))
				  elseif val == 'showDriver' then
			  		TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(player), 'driver')
				  elseif val == 'showFirearms' then
			  		TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(player), 'weapon')
				  end
			  else
				ESX.ShowNotification('¡No hay jugadores cerca!')
			  end
		  end
	  end,
	  function(data, menu)
		  menu.close()
	  end)

  end

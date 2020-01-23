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
--local posx, posy = 0.777, 0.26
--local width, height = 0.07, 0.14
--local LAurl = exports["mugshot"]:getMugshotUrl(GetPlayerPed(-1))

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

	local posx, posy = 0.777, 0.26
	local width, height = 0.07, 0.14
	local x, y = GetActiveScreenResolution()
	--print('x: '..x..' y: '..y) DEV SHIT
		if x == 1920 and y == 1080 then
			posx, posy = 0.777, 0.26
	 		width, height = 0.07, 0.14
		elseif x == 1366 and y == 768 then
			posx, posy = 0.686, 0.366
			width, height = 0.086, 0.196
		elseif x == 1360 and y == 768 then
			posx, posy = 0.685, 0.366
			width, height = 0.087, 0.196
		elseif x == 1600 and y == 900 then
			posx, posy = 0.732, 0.3122
			width, height = 0.073, 0.168
		elseif x == 1400 and y == 1050 then
			posx, posy = 0.694, 0.267
			width, height = 0.083, 0.145
		elseif x == 1440 and y == 900 then
			posx, posy = 0.702, 0.312
			width, height = 0.082, 0.169
		elseif x == 1680 and y == 1050 then
			posx, posy = 0.745, 0.268
			width, height = 0.068, 0.1435
		elseif x == 1280 and y == 720 then
			posx, posy = 0.665, 0.3905
			width, height = 0.09, 0.2105
		elseif x == 1280 and y == 768 then
			posx, posy = 0.665, 0.366
			width, height = 0.091, 0.196
		elseif x == 1280 and y == 800 then
			posx, posy = 0.665, 0.3515
			width, height = 0.091, 0.1895
		elseif x == 1280 and y == 960 then
			posx, posy = 0.665, 0.2925
			width, height = 0.091, 0.1585
		elseif x == 1280 and y == 1024 then
			posx, posy = 0.665, 0.2745
			width, height = 0.091, 0.1475
		elseif x == 1024 and y == 768 then
			posx, posy = 0.5810, 0.366
			width, height = 0.115, 0.1965
		elseif x == 800 and y == 600 then
			posx, posy = 0.4635, 0.4685
			width, height = 0.1455, 0.251
		elseif x == 1152 and y == 864 then
			posx, posy = 0.6275, 0.325
			width, height = 0.1005, 0.175
		elseif x == 1280 and y == 600 then
			posx, posy = 0.665, 0.468
			width, height = 0.0905, 0.251
		end
		--posx, posy = newPosX(x), 0.338 -- (0.686, 0.388) cambiar a otra por el tamaño de la wea....677 338 F(X) = x*(91/554000) + (127869/277000)
		--function not working, if somebody finds a relation between resolution and the fucking coords of the sprite, then tell me :v
		--print(posx)

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
	--drawText() DEV SHIT
	local headshot = GetPedheadshotTxdString (handle)
	while open do
		--print('test2')
		Wait (5)
		DrawSprite (headshot, headshot, posx, posy, width, height, 0.0, 255, 255, 255, 1000)
	end
	if not open then
		UnregisterPedheadshot(handle)
	end
end)

--[[ DEV SHIT
function drawText()
    Citizen.CreateThread(function()
        while open do
            Citizen.Wait(2)
            SetTextFont(4)
            SetTextScale(0.55, 0.55)
            SetTextColour(185, 185, 185, 255)
            SetTextDropshadow(0, 0, 0, 0, 255)
            SetTextDropShadow()
            SetTextOutline()
            SetTextCentre(true)
            BeginTextCommandDisplayText('STRING')
            AddTextComponentSubstringPlayerName('~w~posx: ~g~'..posx..' ~w~posy: ~g~'..posy..' ~w~width: ~r~'..width..' ~w~height: ~r~'..height)
            --EndTextCommandDisplayText(0.175, 0.805)
            EndTextCommandDisplayText(0.5, 0.805) 
        end
    end)
end--]]

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
		--[[ DEV SHIT
		if IsControlPressed(0, Keys['N4']) and open and not IsControlPressed(0, Keys['X']) then --IsControlJustReleased
			posx = posx - 0.0005
		end
		if IsControlPressed(0, Keys['N6']) and open and not IsControlPressed(0, Keys['X']) then
			posx = posx + 0.0005
		end
		if IsControlPressed(0, Keys['N8']) and open and not IsControlPressed(0, Keys['X']) then
			posy = posy - 0.0005
		end
		if IsControlPressed(0, Keys['N5']) and open and not IsControlPressed(0, Keys['X']) then
			posy = posy + 0.0005
		end
		if IsControlJustPressed(0, Keys['N4']) and open and IsControlPressed(0, Keys['X']) then --IsControlJustReleased
			posx = posx - 0.0005
		end
		if IsControlJustPressed(0, Keys['N6']) and open and IsControlPressed(0, Keys['X']) then
			posx = posx + 0.0005
		end
		if IsControlJustPressed(0, Keys['N8']) and open and IsControlPressed(0, Keys['X']) then
			posy = posy - 0.0005
		end
		if IsControlJustPressed(0, Keys['N5']) and open and IsControlPressed(0, Keys['X']) then
			posy = posy + 0.0005
		end
		------
		if IsControlPressed(0, Keys['DOWN']) and open and not IsControlPressed(0, Keys['X']) then --IsControlJustReleased
			height = height - 0.0005
		end
		if IsControlPressed(0, Keys['TOP']) and open and not IsControlPressed(0, Keys['X']) then
			height = height + 0.0005
		end
		if IsControlPressed(0, Keys['RIGHT']) and open and not IsControlPressed(0, Keys['X']) then
			width = width + 0.0005
		end
		if IsControlPressed(0, Keys['LEFT']) and open and not IsControlPressed(0, Keys['X']) then
			width = width - 0.0005
		end
		if IsControlJustPressed(0, Keys['DOWN']) and open and IsControlPressed(0, Keys['X']) then --IsControlJustReleased
			height = height - 0.0005
		end
		if IsControlJustPressed(0, Keys['TOP']) and open and IsControlPressed(0, Keys['X']) then
			height = height + 0.0005
		end
		if IsControlJustPressed(0, Keys['RIGHT']) and open and IsControlPressed(0, Keys['X']) then
			width = width + 0.0005
		end
		if IsControlJustPressed(0, Keys['LEFT']) and open and IsControlPressed(0, Keys['X']) then
			width = width - 0.0005
		end--]]
	end
end)

function openMenu()
	ESX.UI.Menu.Open(
	  'default', GetCurrentResourceName(), 'id_card_menu', {
		  --title    = 'ID menu',
		  title   = 'Tus Documentos',
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

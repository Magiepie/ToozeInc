--todo:
--save trailer data to self[vehhash] for player trailer swap
--passenger payout award splits total award
--change data easy-hard to load types (food,gas,hardware)
--GetGameTimer()


--add some dialog popups for flavor( pickup/dropoff/passing another truck)
--add some normal truck trailering jobs
--create timed loads function
--create difficutly levels with no GPS / timed load = more pay


--wishlist:
-- ESX support
--Sql data?
-- fuel costs money
--have some gerated data logs to use with tablet latter/maybe
-- DOT pulled over rollplay in mind, hours/miles/dates/stops/breaks
--create mobile mechnic job / truck repairs


 semiwallet = 0
local debug = true
local showDropMarker = false
local showPickupMarker = true

TOOZEINC = {DLBLIPS = {} , JPBLIPS ={} }
local DLBLIPS = TOOZEINC.DLBLIPS
local JPBLIPS = TOOZEINC.JPBLIPS
local pickupLOAD = {x,y,z}

print("ToozeInc Running")

RegisterNetEvent("ToozeInc:PickupSemiJob")
RegisterNetEvent("ToozeInc:TrunInSemiJob")

Citizen.CreateThread(function()
	--SpawnTrailers()
	Wait(1000)
	local doonce = true
	while true do
		Wait(1000)
		if IsPedInAnyVehicle(GetPlayerPed(-1), false) then
		local vehicle = GetVehiclePedIsUsing(GetPlayerPed(-1))
		local a,trailer = GetVehicleTrailerVehicle(vehicle) 

		if a then
			if doonce then
			
			--print('Hooked '..GetVehicleClass(trailer))
			showDropMarker = true
			showPickupMarker = false					
			GetDropoff('boxtrailer')
			--HideDropBlip(DLBLIPS[1],false)	
			
			doonce = false	
			end
		else	
			--print('empty')	
			doonce = true	
			showDropMarker = false
			showPickupMarker = true
			--SpawnTrailers()
				
			if DLBLIPS[1] then 			
			HideDropBlip(DLBLIPS[1],true)
			SetBlipRoute(DLBLIPS[1], false) 	
			DLBLIPS[1] = nil
			end
			doonce = true
		end
	end

	end

end)

local TrailerLoad = {  coord1 = {x, y, z},coord2 = {x, y, z} }
Citizen.CreateThread(function()
	while true do --TrailerLoad['bool'] 
		Wait(0)
		if showDropMarker then
		local DropCrd1 = TrailerLoad.coord1
		local DropCrd2 = TrailerLoad.coord2
		local a,trailer = GetVehicleTrailerVehicle(GetVehiclePedIsUsing(GetPlayerPed(-1))) 	
		--local trailerPos = GetEntityCoords(trailer)
		local pos =  GetOffsetFromEntityInWorldCoords(trailer, 0, 5.0, 0)
		local pos2 = GetOffsetFromEntityInWorldCoords(trailer, 0, -5.0, 0)

		local distance1 = GetDistanceBetweenCoords(pos.x,pos.y,pos.z,  DropCrd1.x,DropCrd1.y,DropCrd1.z, true)
		local distance2 = GetDistanceBetweenCoords(pos2.x,pos2.y,pos2.z,  DropCrd2.x,DropCrd2.y,DropCrd2.z,  true)
		
		local distance12 = GetDistanceBetweenCoords(pos2.x,pos2.y,pos2.z,  DropCrd1.x,DropCrd1.y,DropCrd1.z, true)
		local distance21 = GetDistanceBetweenCoords(pos.x,pos.y,pos.z,  DropCrd2.x,DropCrd2.y,DropCrd2.z,  true)
		
		--print(distance1 ..' '.. distance2)
		if distance1 <= 1 and distance2 <= 1 or distance12 <= 1 and distance21 <= 1 then
			local payout = GetTravelPay(pickupLOAD,DropCrd1) 
			local TrailerHealth = GetVehicleBodyHealth(trailer)			
			--GetEntityMaxHealth
			local MaxHealth = 1000
				for  i,v in pairs(semitrailer.tanker) do
				
					if trailer == v.model then
						MaxHealth = 120
					end
				end
			print('trailerhealth: '..TrailerHealth.. ' MaxHP:'..MaxHealth)
			local loadPCT = round((TrailerHealth/MaxHealth)*100)
			local payout2 = round(payout*TrailerHealth/MaxHealth,1)
			
			print('Trailer in DropArea '..TrailerHealth)
			TriggerEvent("chatMessage",'^1 [ ^2 ToozeInc ^1] ^7 Travel Pay $'..payout..' Load %'..loadPCT..' New Pay $'..payout2)		
			semiwallet = semiwallet + payout2

			TriggerEvent("chatMessage",'^1 [ ^2 ToozeInc ^1] ^7 Wallet: $'..semiwallet)	
			showDropMarker = false
			
			HideDropBlip(DLBLIPS[1],true)
			SetBlipRoute(DLBLIPS[1], false) 	
			TrailerLoad = { bool = false, coord1 = {x, y, z},coord2 = {x, y, z} }
			
		end
	end
    end
end)

RegisterNetEvent("ToozeInc:loadrtn")
AddEventHandler("ToozeInc:loadrtn", function(rtn)
 --print(rtn.location)
--TrailerLoad = {rtn}
end)

AddEventHandler("ToozeInc:PickupMarker", function(coords)
	Citizen.CreateThread(function()
		Wait(0)		
		while true do-- showPickupMarker
			Wait(0)
		    DrawMarker(39, coords.x, coords.y, coords.z+2, 0, 0, 0, 0.0, 0.0, 0, 4.001, 4.0001, 4.5001, 2, 155, 255, 200, 1, 1, 1, 1)
		end
	end)
end)

AddEventHandler("ToozeInc:DropoffMarker", function(TR1,H,TR2)	
	CreateThread(function()		
		Wait(0)		
		while showDropMarker do		
			Wait(0)			
			
	        DrawMarker(30 ,TR1.x, TR1.y, TR1.z, 0, 0, 0, 0.0, 0.0, H, 4.001, 4.0001, 4.5001, 2, 155, 255, 200, 1, 0, 0, 0)
		    DrawMarker(30, TR2.x, TR2.y, TR2.z, 0, 0, 0, 0.0, 0.0, H, 4.001, 4.0001, 4.5001, 2, 155, 255, 200, 1, 0, 0, 0)
			
		end
	end)
end)

function DrawText3Ds(x, y, z, text)
	local onScreen,_x,_y=World3dToScreen2d(x,y,z)
	
	if onScreen then
		SetTextScale(0.35, 0.35)
		SetTextFont(4)
		SetTextProportional(1)
		SetTextColour(255, 255, 255, 215)
		SetTextEntry("STRING")
		SetTextCentre(1)
		AddTextComponentString(text)
		DrawText(_x,_y)
	end
end

AddEventHandler("ToozeInc:SpawnTrailers", function()
	SpawnTrailers()
	--SetDropoff()
end)

function GetDropoff(type)	
		local a,trailer = GetVehicleTrailerVehicle(GetVehiclePedIsUsing(GetPlayerPed(-1))) 
		local trailerPos = GetEntityCoords(trailer)
		local droploc = GetDropLocation(type)


		TriggerServerEvent('ToozeInc:SetTrailerLoad',trailer,droploc)	

		local coords = vector3(droploc.front.x,droploc.front.y,droploc.front.z)
		local coords2 = vector3(droploc.back.x,droploc.back.y,droploc.back.z)
		print('droploc: '..droploc.location)
		TriggerEvent("chatMessage",'^1 [ ^2 ToozeInc ^1] ^7 DropLocation: '..droploc.location)	
		TriggerEvent("ToozeInc:DropoffMarker",coords,droploc.front.heading,coords2)	

		TrailerLoad = { 						
						coord1 = {x=droploc.front.x, y=droploc.front.y, z=droploc.front.z},
						coord2 = {x=droploc.back.x, y=droploc.back.y, z=droploc.back.z} 
					}
		pickupLOAD = { x=trailerPos.x, y=trailerPos.y, z=trailerPos.z}			

		if not DLBLIPS[1] then 
			DLBLIPS[1] = AddBlipForCoord(coords)
			CreateBlip(DLBLIPS[1],droploc.location ,479)		
			SetBlipRoute(DLBLIPS[1], true) 	
			SetBlipRouteColour(DLBLIPS[1], 59)
			SetNewWaypoint(droploc.front.x,droploc.front.y)		
		end
end

function SpawnTrailers() -- job pickup locations
	for i,v in ipairs(trailerpickup) do	
		
			
			local trailer = GetTrailer("boxtrailer") -- 
			local coords = vector3(v.x,v.y,v.z)
			local coords2 = vector3(v.Truck.x, v.Truck.y, v.Truck.z+1)
			local vehiclehash = GetHashKey(trailer)			
			RequestModel(vehiclehash)
			SpawnVeh(vehiclehash, v.x, v.y, v.z, v.heading, 1, 0)
			TriggerEvent("ToozeInc:PickupMarker",coords2,v.heading)
			CreatJobBlips(vehiclehash, coords2, 'SemiJob')
		
	end
	
end

function SpawnVeh(vehiclehash, x, y, z, heading)--safe spawning
	CreateThread(function() 
        local waiting = 0
        while not HasModelLoaded(vehiclehash) do
            waiting = waiting + 100
            Citizen.Wait(100)
            if waiting > 5000 then
                ShowNotification("~r~Could not load the vehicle model in time, a crash was prevented.")
                break
            end
		end
		if not IsAnyVehicleNearPoint(x,y, z,5.0) then -- prvent overlapping				
			CreateVehicle(vehiclehash, x, y, z, heading, 1, 0)			
					
		end
    end)
end


function CreatJobBlips(vehiclehash, coords, name)
  if JPBLIPS[vehiclehash] then return end --prvents blipoverlap
  JPBLIPS[vehiclehash] = AddBlipForCoord(coords)
  CreateBlip(JPBLIPS[vehiclehash],name, 477) 		
end
function HidePickBlip(blip,bool)
	if bool then sprite = 0 else sprite = 477 end
	SetBlipSprite(blip, sprite)	
		
end
function HideDropBlip(blip,bool)
	if bool then sprite = 0 else sprite = 479 end
	SetBlipSprite(blip, sprite)
	SetBlipRoute(blip, false) 	
end
function CreateBlip(blip,name,sprite)

		SetBlipSprite(blip, sprite)
		SetBlipScale(blip, 0.9)
		SetBlipColour(blip, 4)
		SetBlipDisplay(blip, 4)
		SetBlipAsShortRange(blip, true)

		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString(name)
		EndTextCommandSetBlipName(blip)
end


function round(num, numDecimalPlaces)
  local mult = 5^(numDecimalPlaces or 0)
  return math.floor(num * mult + 0.5) / mult
end

function GetTrailer(type) -- GetTrailer("tanker","boxtrailer","flatbed"	
 	local trailer = semitrailer[type][math.random(#semitrailer[type])]
	return trailer.model
end

function GetDropLocation(type) -- GetTrailer("tanker","boxtrailer","flatbed"	
	local trailer = semidropoff[type][math.random(#semidropoff[type])]
	--local trailer = semidropoff["boxtrailer"][2]
   return trailer
end

function GetSemiJobLocations(location)

end

function GetSemiDropOff(Difficulty)--"old check latter
	local DropLocation = semidropoff[Difficulty][math.random(#semidropoff[Difficulty])]

	local truckCoords = vector3(DropLocation.truck.x, DropLocation.truck.y, DropLocation.truck.z)
	local trailerCoords = vector3(DropLocation.trailer.x, DropLocation.trailer.y, DropLocation.trailer.z)
	
	return  truckCoords, trailerCoords,DropLocation.pay 
	--change to a single retune with tabled data drop.cords, drop.pay
end

--vector(x,y,z)
function GetTravelPay(pickup,dropoff) 
	local base = 0.5
	if TOOZEDifficty == hard then
		base = 1.0
	end
	local distance = round(GetDistanceBetweenCoords(pickup.x, pickup.y, pickup.z, dropoff.x,dropoff.y,dropoff.z))
	local pay = distance * base
	return pay
end



function getCordoffset(x,y,z,a,offset) -- not working	
	local nx=x+math.sin(a)*math.cos(a)*offset
    local ny=y+math.cos(a)*math.sin(a)*offset
	--print('getCordoffset: '.. nx..' '..ny)
	return vector3(nx,ny,z)
end





--[[
GetVehicleBodyHealth(vehicle )
]]--
--[[AttachVehicleToTrailer(
	vehicle, 
	trailer, 
	radius 
)
]]

--[[ -- load boat to trailer stuff?
	AttachVehicleOnToTrailer(
	vehicle , 
	trailer , 
	p2 , -- offsets?
	p3 , 
	p4 , 
	p5 , 
	p6 , 
	p7 , 
	p8 , 
	p9 , 
	p10, 
	p11 
)
]]


RegisterCommand("semidrop", function() 
	local vehicle = GetVehiclePedIsUsing(GetPlayerPed(-1))
	local a,trailer = GetVehicleTrailerVehicle(vehicle) 
	local trailerPos = GetEntityCoords(trailer)
	local heading = GetEntityHeading(trailer)
	local pos =  GetOffsetFromEntityInWorldCoords(trailer, 0, 5.0, 0)
	local pos2 = GetOffsetFromEntityInWorldCoords(trailer, 0, -5.0, 0)

    TriggerServerEvent("ToozeInc:SaveDropLocation", pos, heading, pos2) 
    TriggerEvent("ToozeInc:DropoffMarker",pos,heading,pos2) 
end, false) 

RegisterCommand("semipick", function(source ,args ,rawCommand ) 
		
	local vehicle = GetVehiclePedIsUsing(GetPlayerPed(-1))
--	local a,trailer = GetVehicleTrailerVehicle(vehicle) 
--	local trailername =  GetEntityModel(trailer) 
	--local trailerPos = GetEntityCoords(trailer)
	local truckPos = GetEntityCoords(GetPlayerPed(-1))
	local heading = GetEntityHeading(vehicle)

	--CreatJobBlips(trailername, truckPos, trailername)

	TriggerEvent("ToozeInc:PickupMarker",truckPos,heading)
	--print(trailername.. ' '.. trailerPos .. ' '..heading)
    TriggerServerEvent("ToozeInc:SavePickupLoc",truckPos,rawCommand  )
end, false) 





RegisterCommand("semitest", function()	
	print('money this session: $'..semiwallet)
	TriggerEvent("chatMessage",'^1 [ ^2 ToozeInc ^1] ^7 Wallet: $'..semiwallet)	

	end, false) 

RegisterCommand("forklift", function()	

	local vehicle = GetVehiclePedIsUsing(GetPlayerPed(-1))
	while true do
		if IsControlJustPressed(0, 27) then 
			SetForkliftForkHeight(vehicle,1.0)
		end 
		Citizen.Wait(0)
	end

end, false)





RegisterCommand("getin", function()	
		local char = GetPlayersLastVehicle()
		local MaxPassenger = GetVehicleMaxNumberOfPassengers(GetPlayersLastVehicle())
		----------------------------------------
		local handle, ped = FindFirstPed() -- This function will set the closest entity to you as the variable entity.
		local finished = false -- FindNextPed will turn the first variable to false when it fails to find another ped in the index
			repeat 
				if not IsEntityDead(ped) then
						pedindex[ped] = {}
				end
			finished, ped = FindNextPed(handle) -- first param returns true while entities are found
		until not finished
	EndFindPed(handle)

	for peds,_ in pairs(pedindex) do
		print('peds: ' .. peds) -- debug
		if peds ~= nil then -- target all peds in the area .... ak-47 style
			SetPedIntoVehicle(peds, GetPlayersLastVehicle(), -2)		-- Player in passenger seat
		end
	end
		end, false) 



	

RegisterCommand("semihard", function()	
	TOOZEDifficty = hard
	TriggerEvent("chatMessage",'^1 [ ^2 ToozeInc ^1] ^7 Set to Hard, Recieving double pay')
		
		end, false) 
RegisterCommand("semieasy", function()	
			TOOZEDifficty = easy
				
end, false) 		


RegisterNetEvent("ToozeInc:DropoffMarker2")--redundant
AddEventHandler("ToozeInc:DropoffMarker2", function(TR1,H,TR2,Tu)
	Citizen.CreateThread(function()
		Wait(0)		
		while true do
	    	Wait(0)
	        DrawMarker(30 ,TR1.x, TR1.y, TR1.z, 0, 0, 0, 0.0, 0.0, H, 4.001, 4.0001, 4.5001, 2, 155, 255, 200, 1, 0, 0, 0)
		    DrawMarker(30, TR2.x, TR2.y, TR2.z, 0, 0, 0, 0.0, 0.0, H, 4.001, 4.0001, 4.5001, 2, 155, 255, 200, 1, 0, 0, 0)
			
			--DrawMarker(39, Tu.x,  Tu.y, Tu.z+2, 0, 0, 0, 0.0, 0.0, 0, 4.001, 4.0001, 4.5001, 2, 155, 255, 200, 1, 1, 1, 1)
			
		end
	end)
end)



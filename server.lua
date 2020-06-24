RegisterServerEvent("ToozeInc:SaveDropLocation")
AddEventHandler("ToozeInc:SaveDropLocation", function( pos, h, pos2 )

--[[
    front   = { x = 205.2892, 6390.55, 31.44019 , rotDegree = 28.286 },  
    back 	= { x = 210.0264, 6381.743, 31.44019}, 
]]--
 file = io.open("resources/[heathensgaming]/[test]/[tooze]/ToozeInc/data/DropLocation.lua", "a")
    if file then
        file:write("\n")
        file:write("front = { x = " .. pos.x .. ", y = " .. pos.y .. ", z = " .. pos.z .. ", heading = ".. h .. "},")
        file:write("\n")
        file:write("back  = { x = " .. pos2.x .. ", y = " .. pos2.y .. ", z = " .. pos2.z .. "}")
        file:write("\n")

        print("Coords wrote to file")
    else
        print("Unable to find file")
    end
    file:close()
end)

RegisterServerEvent("ToozeInc:SavePickupLoc")
AddEventHandler("ToozeInc:SavePickupLoc", function(coord,rawCommand)

 file = io.open("resources/[heathensgaming]/[test]/[tooze]/ToozeInc/data/SavePickupLoc.lua", "a")
   local tnum = 0
 if file then
      --  file:write("[".. tnum .. "] = { x = " .. trailerPos.x .. ", y = " .. trailerPos.y .. ", z = " .. trailerPos.z .. ", heading = ".. h .. " , Truck = { x = " .. truckPos.x .. ", y = " .. truckPos.y .. ", z = " .. truckPos.z .. "} },")
         file:write("["..tnum.."] = { x = ".. coord.x ..", y = ".. coord.y ..",z = ".. coord.z.. " } --"..rawCommand )
        file:write("\n")
        print("Coords wrote to file")
    else
        print("Unable to find file")
    end
    file:close()
end)



RegisterServerEvent("ToozeInc:SavePickupLoc2")
AddEventHandler("ToozeInc:SavePickupLoc2", function(trailerName, trailerPos,h, truckPos )
    local filedir = "resources/[heathensgaming]/[test]/[tooze]/ToozeInc/data/SavePickupLoc.lua"
    local tLines = {}
    local file = io.open(filedir, "r")
    if file then
        
        local sLine = file.readLine()
        while sLine do
          table.insert(tLines, sLine)
          sLine = file.readLine()
        end
        file.close()
     end    
    --file:write("[".. tnum .. "] = { x = " .. trailerPos.x .. ", y = " .. trailerPos.y .. ", z = " .. trailerPos.z .. ", heading = ".. h .. "Truck = { x = " .. truckPos.x .. ", y = " .. truckPos.y .. ", z = " .. truckPos.z .. "} },")
    table.insert(tLines, "This is the last line!")     

    file = io.open(filedir, "w")
        if file then
            for _, sLine in ipairs(tLines) do
                file.writeLine(sLine)
            end   
            file:write("[".. tnum .. "] = { x = " .. trailerPos.x .. ", y = " .. trailerPos.y .. ", z = " .. trailerPos.z .. ", heading = ".. h .. "Truck = { x = " .. truckPos.x .. ", y = " .. truckPos.y .. ", z = " .. truckPos.z .. "} },")
             
        else
            print("Unable to find file")
        end
        file:close()
end)






--[[
Citizen.CreateThread(function() -- clean up unused trailer data
	while true do		
        Citizen.Wait(3600000)       
        for k, v in pairs(TrailerLoad) do  
         if not DoesEntityExist(k) then
             TrailerLoad[k] = nil
         end  
        end     

	end
end)]]

local TrailerLoad = { 
   ['1234'] = { coord1 = {x=1, y=2, z=3},heading = 90 ,coord2 = {x=11, y=22, z},location = "Dillwere", picked = {{x=33, y=33, z=33}} }
}  
function GetTrailerLoad(Trailer)
    if TrailerLoad[Trailer] == nil then return false end
    return TrailerLoad[Trailer]
end

function SetTrailerLoad(Trailer, coord1, heading, coord2 ,location, picked )
    TrailerLoad[Trailer] = {}
   --[[ TrailerLoad[Trailer].coord1 = coord1
    TrailerLoad[Trailer].heading = heading
    TrailerLoad[Trailer].coord2 = coord2
    TrailerLoad[Trailer].location = location   
    TrailerLoad[Trailer].picked = picked]]--
end

 
RegisterServerEvent("ToozeInc:GetTrailerLoad")
AddEventHandler("ToozeInc:GetTrailerLoad", function(Trailer)
    TriggerClientEvent("ToozeInc:loadrtn", source,  GetTrailerLoad(Trailer))
  -- return GetTrailerLoad(Trailer)
end)

RegisterServerEvent("ToozeInc:SetTrailerLoad")
AddEventHandler("ToozeInc:SetTrailerLoad", function(Trailer)
   -- SetTrailerLoad(Trailer, coord1, heading, coord2 ,location, picked )
end)





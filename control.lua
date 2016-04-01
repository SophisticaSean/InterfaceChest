require "defines"
require "util"

-- How often to cycle through chests for input
local inputThrottle = 12

-- How often to cycle through chests for output
-- ~yellow = 10, ~red =6
local outputThrottle = 6

-- How many actions to take each cycle
local inputMultiplier = 8
-- Inventory transfer stack size
local maxStackSize = 4

-- Cardinal Directions
local north = defines.direction.north
local east = defines.direction.east
local south = defines.direction.south
local west = defines.direction.west

-- Help Inspect adjacent tiles
function areaNorth(position) return {{position.x - 0.5, position.y - 1.5},{position.x + 0.5, position.y - 0.5}} end
function areaSouth(position) return {{position.x - 0.5, position.y + 0.5},{position.x + 0.5, position.y + 1.5}} end
function areaEast(position)  return {{position.x + 0.5, position.y - 0.5},{position.x + 1.5, position.y + 0.5}} end
function areaWest(position)  return {{position.x - 1.5, position.y - 0.5},{position.x - 0.5, position.y + 0.5}} end
function areaSelf(position)  return {{position.x - 0.5, position.y - 0.5},{position.x + 0.5, position.y + 0.5}} end

-------------------
function InterfaceChest_Initialize(event)	
	if global.InterfaceChest_MasterList == nil then
		global.InterfaceChest_MasterList = {}
	end
end

-------------------
function InterfaceChest_Create(event)
	if event.created_entity.name == "interface-chest" then
		table.insert(global.InterfaceChest_MasterList, event.created_entity);
	end
end

-------------------
function InterfaceChest_RunStep(event)
	local searchEntity
	for index, interfaceChest in pairs(global.InterfaceChest_MasterList) do		
		if interfaceChest.valid then
			local owner = "player"
			local bar = interfaceChest.get_inventory(1).getbar()							
			if 0 == (game.tick+index) % inputThrottle then
				if bar == 0 and interfaceChest.name == "interface-chest-active" then
					voidChest(interfaceChest)
				elseif bar ~= 0 and interfaceChest.name == "interface-chest-active" then
					swapChest(interfaceChest, index, owner)
					break
				elseif bar == 0 and interfaceChest.name == "interface-chest" then
					swapChest(interfaceChest, index, owner)
					break
				else
					local _inputs= getInputBelts(interfaceChest.position, owner)
					for _, belt in pairs(_inputs) do
						if belt.type == "splitter" then	
							if (belt.position.x > interfaceChest.position.x and belt.position.y > interfaceChest.position.y) or (belt.position.x < interfaceChest.position.x and belt.position.y < interfaceChest.position.y) then
								beltToChest(belt, defines.transport_line.left_split_line, interfaceChest)
								beltToChest(belt, defines.transport_line.right_split_line, interfaceChest)
							else
								beltToChest(belt, defines.transport_line.secondary_left_split_line, interfaceChest)
								beltToChest(belt, defines.transport_line.secondary_right_split_line, interfaceChest)
							end
						else
						  beltToChest(belt, defines.transport_line.left_line, interfaceChest)
						  beltToChest(belt, defines.transport_line.right_line, interfaceChest)
						end
					end
					
					if _inputs[1] == nil then
						local inventories = getInventories(interfaceChest.position, owner)
						for _, inventory in pairs(inventories) do
							  sourceToTargetInventory(inventory, interfaceChest)
						end
					end
				end
			end
			if 0 == (game.tick+index) % outputThrottle then
				if interfaceChest.get_inventory(1).is_empty() == false then					
					local _outputs = getOutputBelts(interfaceChest.position, owner)
					for _, belt in pairs(_outputs) do					
						if belt.type == "splitter" then	
							if (belt.position.x > interfaceChest.position.x and belt.position.y > interfaceChest.position.y) or (belt.position.x < interfaceChest.position.x and belt.position.y < interfaceChest.position.y) then
								chestToBelt(belt, defines.transport_line.left_line, interfaceChest)
								chestToBelt(belt, defines.transport_line.right_line, interfaceChest)
							else
								chestToBelt(belt, defines.transport_line.secondary_left_line, interfaceChest)
								chestToBelt(belt, defines.transport_line.secondary_right_line, interfaceChest)
							end
						else
						  chestToBelt(belt, defines.transport_line.left_line, interfaceChest)
						  chestToBelt(belt, defines.transport_line.right_line, interfaceChest)
						end
					end
					
					if _outputs[1] == nil then
						local inventories = getInventories(interfaceChest.position, owner)
						for _, inventory in pairs(inventories) do
							  sourceToTargetInventory(interfaceChest, inventory)
						end
					end
				end
			end
		else
			global.InterfaceChest_MasterList[index] = nil
		end
	end
end

function swapChest(source, key, owner)
	local name
	if source.name == "interface-chest" then
		name = "interface-chest-active"
	else
		name = "interface-chest"
	end

	local newChest = game.get_surface(1).create_entity{name=name, position=source.position, force=owner, bar = source.get_inventory(1).getbar()}
	if newChest then
		source.destroy()
		global.InterfaceChest_MasterList[key] = newChest;							
	end

end

function voidChest(voidInterfaceChest)
	local owner = "player"
	voidInterfaceChest.get_inventory(1).clear()
	local _inputs= getInputBelts(voidInterfaceChest.position)
	for _, belt in pairs(_inputs) do
		if belt.type == "splitter" then	
			if (belt.position.x > voidInterfaceChest.position.x and belt.position.y > voidInterfaceChest.position.y) or (belt.position.x < voidInterfaceChest.position.x and belt.position.y < voidInterfaceChest.position.y) then
				beltToVoid(belt, defines.transport_line.left_split_line)
				beltToVoid(belt, defines.transport_line.right_split_line)
			else
				beltToVoid(belt, defines.transport_line.secondary_left_split_line)
				beltToVoid(belt, defines.transport_line.secondary_right_split_line)
			end
		else
		  beltToVoid(belt, defines.transport_line.left_line)
		  beltToVoid(belt, defines.transport_line.right_line)
		end
	end
end


function beltToVoid(belt, laneNumber)
	local lane = belt.get_transport_line(laneNumber).get_contents()
	for item, size in pairs(lane) do
		local itemstack = {name=item, count=size}
		belt.get_transport_line(laneNumber).remove_item(itemstack)		
	end
end

function beltToChest(belt, laneNumber, chest)
  local lane = belt.get_transport_line(laneNumber).get_contents()
  for item, size in pairs(lane) do
	local itemstack = {name=item, count=math.min(inputMultiplier,size)}
	if chest.can_insert(itemstack) then
		itemstack.count = chest.insert(itemstack)
		belt.get_transport_line(laneNumber).remove_item(itemstack)
	end
	break
  end
end

function chestToBelt(belt, laneNumber, chest)
  local _inventory = chest.get_inventory(1).get_contents()
  for item, size in pairs(_inventory) do
	local itemstack = {name=item, count=1}
	if belt.get_transport_line(laneNumber).insert_at_back(itemstack) then
		chest.get_inventory(1).remove(itemstack)
	end
	break
  end
end

function sourceToTargetInventory(source, target)
  local _inventory = source.get_inventory(1).get_contents()
  for item, size in pairs(_inventory) do
	local itemstack = {name=item, count=math.min(maxStackSize,size)}
	if target.can_insert(itemstack) then
		itemstack.count = target.insert(itemstack)
		source.get_inventory(1).remove(itemstack)
	end
	break
  end
end

function getInputBelts(position, owner)
	local belts = {}
		
	local _north = checkForTransportEntity(areaNorth(position), south, "output")
	if _north then   
		table.insert(belts, _north)
	end
	
	local _east = checkForTransportEntity(areaEast(position), west, "output")
	if _east then
		table.insert(belts, _east)
	end
	
	local _south = checkForTransportEntity(areaSouth(position), north, "output")
	if _south then
		table.insert(belts, _south)
	end
	
	local _west = checkForTransportEntity(areaWest(position), east, "output")
	if _west then
		table.insert(belts, _west)
	end

    return belts 
end

function getOutputBelts(position, owner)
	local belts = {}
	local checkNorth
	local checkEast
	local checkSouth
	local checkWest
		
	local _north = checkForTransportEntity(areaNorth(position), north, "input")
	if _north then
		checkWest = checkForTransportEntity(areaWest(_north.position), east, "output")
		checkEast = checkForTransportEntity(areaEast(_north.position), west, "output")
		if (checkWest and checkEast) or (checkWest == nil and checkEast == nil) then
			table.insert(belts, _north)
		end
	end
	
	local _east = checkForTransportEntity(areaEast(position), east, "input")
	if _east then
		checkNorth = checkForTransportEntity(areaNorth(_east.position), south, "output")
		checkSouth = checkForTransportEntity(areaSouth(_east.position), north, "output")
		if (checkNorth and checkSouth) or (checkNorth == nil and checkSouth == nil) then
			table.insert(belts, _east)
		end
	end
	
	local _south = checkForTransportEntity(areaSouth(position), south, "input")
	if _south then
		checkWest = checkForTransportEntity(areaWest(_south.position), east, "output")
		checkEast = checkForTransportEntity(areaEast(_south.position), west, "output")		
		if (checkWest and checkEast) or (checkWest == nil and checkEast == nil) then
			table.insert(belts, _south)
		end
	end
	
	local _west = checkForTransportEntity(areaWest(position), west, "input")
	if _west then
		checkNorth = checkForTransportEntity(areaNorth(_west.position), south, "output")
		checkSouth = checkForTransportEntity(areaSouth(_west.position), north, "output")
		if (checkNorth and checkSouth) or (checkNorth == nil and checkSouth == nil) then
			table.insert(belts, _west)
		end
	end

    return belts 
end

function checkForTransportEntity(_area, _direction, undergroundType, owner)
	local transportEntity = game.get_surface(1).find_entities_filtered{type="transport-belt", area=_area, force= owner}	
	if transportEntity[1] and transportEntity[1].direction == _direction then   
		return transportEntity[1] 
	end
	
	transportEntity = game.get_surface(1).find_entities_filtered{type="transport-belt-to-ground", area=_area, force= owner}	
	if transportEntity[1] and transportEntity[1].belt_to_ground_type == undergroundType and transportEntity[1].direction == _direction then   
		return transportEntity[1] 
	end

	transportEntity = game.get_surface(1).find_entities_filtered{type="splitter", area=_area, force= owner}	
	if transportEntity[1] and transportEntity[1].direction == _direction then   
		return transportEntity[1] 
	end
end

function getInventories(position, owner)
	local iventories = {}
	local _north = inventorySearch(areaNorth(position))
	local _east  = inventorySearch(areaEast(position))
	local _south = inventorySearch(areaSouth(position))
	local _west  = inventorySearch(areaWest(position))

	if _north then
		table.insert(iventories, _north)
	end
	
	if _east then
		table.insert(iventories, _east)
	end
	
	if _south then
		table.insert(iventories, _south)
	end
	
	if _west then
		table.insert(iventories, _west)
	end
	
	return iventories
end

function inventorySearch (_area)
	local _inventory = game.get_surface(1).find_entities_filtered{type="cargo-wagon", area=_area, force= owner}	
	if _inventory[1] and _inventory[1].train.speed==0 then
		return _inventory[1] 
	end
	
	local _inventory = game.get_surface(1).find_entities_filtered{type="locomotive", area=_area, force= owner}	
	if _inventory[1] and _inventory[1].train.speed==0 then
		return _inventory[1] 
	end	
	
	_inventory = game.get_surface(1).find_entities_filtered{type="logistic-container", area=_area, force= owner}	
	if _inventory[1] then   
		return _inventory[1] 
	end
	
end


function debugPrint(thing)
	for _, player in pairs(game.players) do	
		player.print(serpent.block(thing))
	end
end

script.on_init(InterfaceChest_Initialize)
script.on_event(defines.events.on_tick, InterfaceChest_RunStep)
script.on_event(defines.events.on_built_entity, InterfaceChest_Create)
script.on_event(defines.events.on_robot_built_entity, InterfaceChest_Create)
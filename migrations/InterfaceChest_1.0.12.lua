for i, force in pairs(game.forces) do 
	force.reset_recipes()
end

for i, force in pairs(game.forces) do 
	force.reset_technologies()
end

for i, force in pairs(game.forces) do 
	if force.technologies["advanced-material-processing"].researched then 
		force.recipes["interface-chest-trash"].enabled = true
	end
	if force.technologies["advanced-electronics"].researched then 
		force.recipes["interface-chest"].enabled = true
	end
	if force.technologies["logistics-3"].researched then 
		force.recipes["interface-belt-balancer"].enabled = true
	end
	
end

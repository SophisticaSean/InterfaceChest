for i, force in pairs(game.forces) do 
 force.reset_recipes()
end

for i, force in pairs(game.forces) do 
 force.reset_technologies()
end

for i, force in pairs(game.forces) do 
 if force.technologies["advanced-electronics"].researched then 
   force.recipes["interface-chest"].enabled = true
 end
end


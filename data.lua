require("prototypes.entity")
require("prototypes.recipe")
require("prototypes.item")


table.insert(data.raw.technology["advanced-material-processing"].effects,{type = "unlock-recipe", recipe = "interface-chest-trash"})
table.insert(data.raw.technology["advanced-electronics"].effects,{type = "unlock-recipe", recipe = "interface-chest"})
table.insert(data.raw.technology["logistics-3"].effects,{type = "unlock-recipe", recipe = "interface-belt-balancer"})
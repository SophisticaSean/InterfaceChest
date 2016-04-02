data:extend {
	{
    type = "item",
    name = "interface-chest",
    icon = "__InterfaceChest__/graphics/icon/interfacechest.png",
    flags = {"goes-to-quickbar"},
    subgroup = "storage",
    order = "a[items]-s[interface-chest]",
    place_result = "interface-chest",
    stack_size = 50
	},
	{
    type = "recipe",
    name = "interface-chest",
    enabled = "true",
    ingredients =
		{
		  {"smart-chest", 1},
		  {"fast-inserter", 4},
		  {"fast-transport-belt", 4},
		  {"processing-unit", 2}
		},
    result = "interface-chest"
	},
	{
    type = "smart-container",
    name = "interface-chest",
    icon = "__InterfaceChest__/graphics/icon/interfacechest.png",
    flags = {"placeable-neutral", "player-creation"},
    minable = {mining_time = 1, result = "interface-chest"},
    max_health = 200,
    corpse = "small-remnants",
    open_sound = { filename = "__base__/sound/metallic-chest-open.ogg", volume=0.65 },
    close_sound = { filename = "__base__/sound/metallic-chest-close.ogg", volume = 0.7 },
    resistances =
    {
      {
        type = "fire",
        percent = 90
      }
    },
    collision_box = {{-0.35, -0.35}, {0.35, 0.35}},
    selection_box = {{-0.5, -0.5}, {0.5, 0.5}},
    fast_replaceable_group = "container",
    inventory_size = 48,
	picture =
	{
	  filename = "__InterfaceChest__/graphics/interfacechest.png",
	  priority = "extra-high",
	  width = 38,
	  height = 32,
	  shift = {0.1, 0}
	},
	circuit_wire_connection_point =
    {
      shadow =
      {
        red = {0.7, -0.3},
        green = {0.7, -0.3}
      },
      wire =
      {
        red = {0.3, -0.8},
        green = {0.3, -0.8}
      }
    },
    circuit_wire_max_distance = 7.5
	},
	-- Trash Can Version
	{
    type = "smart-container",
    name = "interface-chest-active",
    icon = "__InterfaceChest__/graphics/icon/interfacechest.png",
    flags = {"placeable-neutral", "player-creation"},
    minable = {mining_time = 1, result = "interface-chest"},
	order = "a[items]-s[interface-chest]",
    max_health = 200,
    corpse = "small-remnants",
    open_sound = { filename = "__base__/sound/metallic-chest-open.ogg", volume=0.65 },
    close_sound = { filename = "__base__/sound/metallic-chest-close.ogg", volume = 0.7 },
    resistances =
    {
      {
        type = "fire",
        percent = 90
      }
    },
    collision_box = {{-0.35, -0.35}, {0.35, 0.35}},
    selection_box = {{-0.5, -0.5}, {0.5, 0.5}},
    fast_replaceable_group = "container",
    inventory_size = 48,
	picture =
	{
	  filename = "__InterfaceChest__/graphics/interfacechest_active.png",
	  priority = "extra-high",
	  width = 38,
	  height = 32,
	  shift = {0.1, 0}
	},
	circuit_wire_connection_point =
    {
      shadow =
      {
        red = {0.7, -0.3},
        green = {0.7, -0.3}
      },
      wire =
      {
        red = {0.3, -0.8},
        green = {0.3, -0.8}
      }
    },
    circuit_wire_max_distance = 7.5
	},
}

table.insert(data.raw.technology["advanced-electronics"].effects,{type = "unlock-recipe", recipe = "interface-chest"})
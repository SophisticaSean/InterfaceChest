data:extend {
	{
    type = "item",
    name = "interface-chest",
    icon = "__InterfaceChest__/graphics/icon/interfacechest.png",
    flags = {"goes-to-quickbar"},
    subgroup = "storage",
    order = "a[items]-e[interface-chest]",
    place_result = "interface-chest",
    stack_size = 50
	},
	{
    type = "item",
    name = "interface-chest-trash",
    icon = "__InterfaceChest__/graphics/icon/trashchest.png",
    flags = {"goes-to-quickbar"},
    subgroup = "storage",
    order = "a[items]-f[interface-chest]",
    place_result = "interface-chest-trash",
    stack_size = 50
	},
	{
    type = "recipe",
    name = "interface-chest",
    enabled = "false",
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
    type = "recipe",
    name = "interface-chest-trash",
    enabled = "false",
    ingredients =
		{
		  {"iron-chest", 1},
		  {"fast-inserter", 2},
		  {"basic-transport-belt", 2},
		  {"stone-furnace", 1}
		},
    result = "interface-chest-trash"
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
        red = {0.6, 0.0},
        green = {0.4, 0.0}
      },
      wire =
      {
        red = {-0.1, -0.5},
        green = {0.1, -0.5}
      }
    },
    circuit_wire_max_distance = 7.5
	},
	-- Trash Can Version
	{
    type = "container",
    name = "interface-chest-trash",
    icon = "__InterfaceChest__/graphics/icon/trashchest.png",
    flags = {"placeable-neutral", "player-creation"},
    minable = {mining_time = 1, result = "interface-chest-trash"},
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
    inventory_size = 32,
	picture =
		{
		  filename = "__InterfaceChest__/graphics/trashchest.png",
		  priority = "extra-high",
		  width = 38,
		  height = 32,
		  shift = {0.1, 0}
		}
	},

	{ -- Chest Power entity
		type = "accumulator",
		name = "interface-chest-power",
		icon = "__InterfaceChest__/graphics/icon/interfacechest.png",
		flags = {"placeable-neutral", "player-creation"},
		order="z",
		minable = {hardness = .5, mining_time = 2.0, result = "raw-wood"},
		max_health = 200,
		corpse = "medium-remnants",
		collision_mask = {"ghost-layer"},
		collision_box = {{-0.4, -0.4}, {0.4, 0.4}},
		selection_box = {{-0.5, -0.5}, {0.5, 0.5}},
		energy_source =
		{
		  type = "electric",
		  buffer_capacity = "100kJ",
		  usage_priority = "secondary-input",
		  input_flow_limit = "500kW",
		  output_flow_limit = "0kW"
		},
		picture =
		{
		  filename = "__InterfaceChest__/graphics/interfacechestpower.png",
		  priority = "extra-high",
		  width = 1,
		  height = 1,
		  --shift = {0.7, -0.2}
		},
		charge_animation =
		{
		  filename = "__InterfaceChest__/graphics/interfacechestpower.png",
		  width = 1,
		  height = 1,
		  line_length = 1,
		  frame_count = 1,
		  shift = {0, 0},
		  animation_speed = 0.5
		},
		charge_cooldown = 0,
		charge_light = {intensity = 0, size = 0},
		discharge_animation =
		{
		  filename = "__InterfaceChest__/graphics/interfacechestpower.png",
		  width = 1,
		  height = 1,
		  line_length = 1,
		  frame_count = 1,
		  shift = {0, 0},
		  animation_speed = 0.5
		},
		discharge_cooldown = 0,
		discharge_light = {intensity = 0, size = 0},
		working_sound =
		{
		  sound =
		  {
			filename = "__base__/sound/accumulator-working.ogg",
			volume = 1
		  },
		  idle_sound = {
			filename = "__base__/sound/accumulator-idle.ogg",
			volume = 0.4
		  },
		  max_sounds_per_type = 0
		},
	},
}

table.insert(data.raw.technology["advanced-material-processing"].effects,{type = "unlock-recipe", recipe = "interface-chest-trash"})
table.insert(data.raw.technology["advanced-electronics"].effects,{type = "unlock-recipe", recipe = "interface-chest"})
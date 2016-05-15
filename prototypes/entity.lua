require ("prototypes.belt-balancer-pictures")

data:extend(
	{
		{
		-- Interface Chest
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
		collision_box = {{-0.25, -0.25}, {0.25, 0.25}},
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
		{
		-- Trash Can Version
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
		collision_box = {{-0.25, -0.25}, {0.25, 0.25}},
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
		{
		-- Chest Power Supply
		type = "electric-turret",
		name = "interface-chest-power",
		order="z",
		icon = "__InterfaceChest__/graphics/icon/interfacechest.png",
		flags = { "placeable-player", "placeable-enemy", "player-creation"},
		minable = { mining_time = 2, result = "raw-wood" },
		max_health = 200,
		corpse = "medium-remnants",
		collision_mask = {"ghost-layer"},
		collision_box = {{-0.25, -0.25}, {0.25, 0.25}},
		selection_box = {{-0.5, -0.5}, {0.5, 0.5}},
		rotation_speed = 0.01,
		preparing_speed = 0.05,
		dying_explosion = "medium-explosion",
		folding_speed = 0.05,
		energy_source =
		{
		  type = "electric",
		  buffer_capacity = "1000kJ",
		  input_flow_limit = "1000kW",
		  usage_priority = "primary-input"
		},
		folded_animation =
		{
		  layers =
		  {
			{
			  filename = "__InterfaceChest__/graphics/interfacechestpower.png",
			  priority = "low",
			  width = 1,
			  height = 1,
			  axially_symmetrical = false,
			  frame_count=1,
			  direction_count = 1,
			  shift = { 0.109375, 0.03125 }
			},
		  }
		},
		preparing_animation =
		{
		  layers =
		  {
	 
		  }
		},
		prepared_animation =
		{
		  layers =
		  {
			
			
		  }
		},
		folding_animation = 
		{
		  layers =
		  {

		  }
		},
		base_picture =
		{
		  layers =
		  {
			{
			  filename = "__InterfaceChest__/graphics/interfacechestpower.png",
			  priority = "low",
			  width = 1,
			  height = 1,
			  axially_symmetrical = false,
			  direction_count = 1,
			  shift = { 0.109375, 0.03125 }
			},
			
		  }
		},
		vehicle_impact_sound =  { filename = "__base__/sound/car-metal-impact.ogg", volume = 0.65 },
		attack_parameters =
		{
		  type = "projectile",
		  ammo_category = "electric",
		  cooldown = 20,
		  projectile_center = {0, -0.2},
		  projectile_creation_distance = 1.4,
		  range = 0,
		  damage_modifier = 4,
		  ammo_type =
		  {
			type = "projectile",
			category = "laser-turret",
			energy_consumption = "2000MW",
			action =
			{
			  {
				type = "direct",
				action_delivery =
				{
				  {
					type = "projectile",
					projectile = "laser",
					starting_speed = 0.28
				  }
				}
			  }
			}
		  },
		  
		}
	  },
	  {
		type = "transport-belt",
		name = "interface-belt-balancer",
		icon = "__InterfaceChest__/graphics/icon/belt-balancer.png",
		flags = {"placeable-neutral", "player-creation"},
		minable = {hardness = 0.2, mining_time = 0.3, result = "interface-belt-balancer"},
		max_health = 50,
		corpse = "small-remnants",
		resistances =
		{
		  {
			type = "fire",
			percent = 50
		  }
		},
		collision_box = {{-0.4, -0.4}, {0.4, 0.4}},
		selection_box = {{-0.5, -0.5}, {0.5, 0.5}},
		working_sound =
		{
		  sound =
		  {
			filename = "__base__/sound/express-transport-belt.ogg",
			volume = 0.4
		  },
		  max_sounds_per_type = 3
		},
		animation_speed_coefficient = 32,
		animations =
		{
		  filename = "__InterfaceChest__/graphics/belt-balancer.png",
		  priority = "extra-high",
		  width = 40,
		  height = 40,
		  frame_count = 32,
		  direction_count = 12
		},
		belt_horizontal = belt_balancer_horizontal, -- specified in transport-belt-pictures.lua
		belt_vertical = belt_balancer_vertical,
		ending_top = belt_balancer_ending_top,
		ending_bottom = belt_balancer_ending_bottom,
		ending_side = belt_balancer_ending_side,
		starting_top = belt_balancer_starting_top,
		starting_bottom = belt_balancer_starting_bottom,
		starting_side = belt_balancer_starting_side,
		ending_patch = ending_patch_prototype,
		ending_patch = ending_patch_prototype,
		fast_replaceable_group = "transport-belt",
		speed = 0.09375
	  },
 
	}
)
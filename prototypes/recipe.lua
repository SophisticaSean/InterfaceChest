data:extend(
	{
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
		}
	}
)
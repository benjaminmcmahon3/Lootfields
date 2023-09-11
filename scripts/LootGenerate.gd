const json_loader = preload("res://scripts/JsonLoader.gd")

static var food_scene: PackedScene = preload("res://LootItem.tscn")

static func generate(parent_node: Node, player_node, coords: Vector2, loot_file_path):
	var loot_config: Dictionary = json_loader._loadJson(loot_file_path)

	for loot_key in loot_config.keys():
		var loot_item = loot_config[loot_key]
		var item_quantity = loot_item.count

		for i in range(item_quantity):
			var loot_instance = food_scene.instantiate()
			loot_instance.set_item_name(loot_item.name)
			loot_instance.set_item_display_name(loot_item.display_name)
			loot_instance.set_texture(loot_item.path)

			var new_x = randi() % int(coords.x)
			var new_y = randi() % int(coords.y)
			loot_instance.position = Vector2(new_x, new_y)

			loot_instance.connect("loot_taken", Callable(player_node, "_on_loot_taken"))

			parent_node.add_child(loot_instance)

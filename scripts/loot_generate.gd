const loot: Dictionary = {
	"bread": {
		"type": "Food",
		"path": "res://assets/Ghostpixxells_pixelfood/07_bread.png",
		"count": 500
	}
}

var food_scene: PackedScene = preload("res://Food.tscn")

func generate(parent_node: Node, player_node, coords: Vector2):
	for loot_key in loot.keys():
		var loot_item = loot[loot_key]
		var item_quantity = loot_item.count

		for i in range(item_quantity):
			var loot_instance = food_scene.instantiate()
			var new_x = randi() % int(coords.x)
			var new_y = randi() % int(coords.y)
			loot_instance.position = Vector2(new_x, new_y)

			loot_instance.connect("loot_area_entered", Callable(player_node, "_on_loot_area_entered"))

			parent_node.add_child(loot_instance)

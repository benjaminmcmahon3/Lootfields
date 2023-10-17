extends Resource
class_name LootGenerator

## Restrict generation of items to those containing these areas
@export var item_areas: Array[String]
@export var player_inventory: Inventory

static var loot_scene: PackedScene = preload("res://Items/LootItem.tscn")

func generate(parent_node: Node2D, player_node, coords: Vector2):
	var items = ItemDb.ITEMS

#	# Find items where the item_areas have matches with the areas of each item
	var matched_items = []
	for item in items.values():
		if item.areas == null:
			continue

		for area in item.areas:
			for item_area in item_areas:
				if area == item_area:
					matched_items.append(item)

	for item in matched_items:
		var item_quantity = 25

		for i in range(item_quantity):
			var loot_instance: LootItem = loot_scene.instantiate()

			loot_instance.item_data = item

			var new_x = randi() % int(coords.x)
			var new_y = randi() % int(coords.y)
			loot_instance.position = Vector2(new_x, new_y)

			loot_instance.connect("loot_taken", Callable(player_inventory, "add_item").bind(item.unique_id))

			parent_node.add_child(loot_instance)

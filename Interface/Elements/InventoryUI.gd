extends CanvasLayer

const inventory_item: PackedScene = preload("res://Interface/Elements/InventoryListItem.tscn")

@export var inventory: Inventory = null:
	set = set_inventory

@onready var inventory_list := $InventoryList

# Called when the node enters the scene tree for the first time.
func _ready():
	update_items_display()
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func set_inventory(new_inventory: Inventory) -> void:
	inventory = new_inventory
	inventory.connect("changed", Callable(self, "update_items_display"))

func update_items_display():
	for n in inventory_list.get_children():
		inventory_list.remove_child(n)
		n.queue_free()

	var items = inventory.get_all()

	var item_dict = {}

	for loot_item in items:
		var mapped = item_dict.get(loot_item.item_name)
		if mapped:
			var count = mapped.count + 1
			mapped.count = count
		else:
			item_dict[loot_item.item_name] = {
				"display_name": loot_item.display_name,
				"count": 1
			}


	for loot_item in item_dict:
		var item_value = item_dict.get(loot_item)
		var loot_item_instance = preload("res://Interface/Elements/InventoryListItem.tscn").instantiate()
		loot_item_instance.get_node("ItemName").text = item_value.display_name
		loot_item_instance.get_node("Quantity").text = str(item_value.count)

		inventory_list.add_child(loot_item_instance)

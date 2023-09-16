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

	print("inventory.items : ", inventory.items())
	for item in inventory.items():
		var loot_item_instance = preload("res://Interface/Elements/InventoryListItem.tscn").instantiate()
		var item_data = ItemDb.get_item_data(item.unique_id)
		loot_item_instance.get_node("ItemName").text = item_data.display_name
		loot_item_instance.get_node("Quantity").text = str(item.count)

		inventory_list.add_child(loot_item_instance)

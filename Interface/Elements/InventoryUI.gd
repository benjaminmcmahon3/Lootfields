extends CanvasLayer

const inventory_item: PackedScene = preload("res://Interface/Elements/InventoryListItem.tscn")

@export var inventory: Inventory = null:
	set = set_inventory

@onready var inventory_tab_container := $PrototypeInventory

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
	for tab in inventory_tab_container.get_children():
		var tab_children = tab.get_children()
	
		for n in tab_children:
			tab.remove_child(n)
			n.queue_free()
	
	for tab in inventory_tab_container.get_children():
		for item in inventory.items():
			if tab.name == "Food":
				var loot_item_instance: InventoryListItem = preload("res://Interface/Elements/InventoryListItem.tscn").instantiate()
				var item_data = ItemDb.get_item_data(item.unique_id)
				loot_item_instance.get_node("MarginContainer/ItemName").text = item_data.display_name
				loot_item_instance.get_node("MarginContainer/Quantity").text = str(item.count)
				tab.add_child(loot_item_instance)	

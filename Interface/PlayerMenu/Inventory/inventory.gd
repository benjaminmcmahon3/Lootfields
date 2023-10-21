extends TabContainer

const inventory_item: PackedScene = preload("res://Interface/Elements/InventoryListItem.tscn")

@export var inventory: Inventory = null:
	set = set_inventory

@onready var weapons_tab := $Weapons/VBoxContainer
@onready var armor_tab := $Armor/VBoxContainer
@onready var food_tab := $Food/VBoxContainer
@onready var keys_tab := $Keys/VBoxContainer
@onready var potions_tab := $Potions/VBoxContainer
@onready var misc_tab := $Misc/VBoxContainer

# Called when the node enters the scene tree for the first time.
func _ready():
	update_items_display()

func set_inventory(new_inventory: Inventory) -> void:
	inventory = new_inventory
	inventory.connect("changed", Callable(self, "update_items_display"))

func update_items_display():
	for tab in self.get_children():
		var vbox_container = tab.get_node("VBoxContainer")
		for n in vbox_container.get_children():
			vbox_container.remove_child(n)
			n.queue_free()

	for tab in self.get_children():
		for item in inventory.items():
			if tab.name == "Food":
				var loot_item_instance: InventoryListItem = preload("res://Interface/Elements/InventoryListItem.tscn").instantiate()
				loot_item_instance.item_unique_id = item.unique_id
				
				var item_data = ItemDb.get_item_data(item.unique_id)
				loot_item_instance.get_node("MarginContainer/ItemName").text = item_data.display_name
				loot_item_instance.get_node("MarginContainer/Quantity").text = str(item.count)
				
				tab.get_node("VBoxContainer").add_child(loot_item_instance)
				

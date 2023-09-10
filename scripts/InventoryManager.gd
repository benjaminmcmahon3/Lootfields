class_name InventoryManager

var inventory = []

func _init():
	pass
	
func add_item(item):
	inventory.append(item)
	
func get_all():
	return inventory

extends Resource
class_name Inventory

@export var inventory = {}

func add_item(item_id: String) -> void:
	if item_id in inventory:
		inventory[item_id].count += 1 
	else:
		inventory[item_id] = {
			"unique_id": item_id,
			"count": 1
		}

	emit_changed()

func remove_item(item_id: String) -> bool:
	if not item_id in inventory:
		printerr("Item %s does not exist in inventory" % [item_id])
		return false
		
	var item = inventory[item_id]
	item.count -= 1
	
	if item.count == 0:
		inventory.erase(item_id)
	
	emit_changed()
	return true

func items():
	return inventory.values()

extends Resource
class_name Inventory

@export var inventory = []

func add_item(item):
	inventory.append(item)
	emit_changed()

func get_all():
	return inventory

extends Resource
class_name ItemData

@export_category("Item Data")
@export var unique_id: String
@export var display_name: String
@export_multiline var description: String
@export_range(0, 1000, 1, "or_greater") var weight: int
@export var texture: Texture2D

@export_category("Spawn Areas")
@export var areas = []
@export var tags = []

func _to_string():
	print("unique_id : %s" % [unique_id])
	print("display_name : %s" % [unique_id])
	print("description : %s" % [description])
	print("weight : %s" % [weight])

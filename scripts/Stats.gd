extends Resource
class_name Stats

@export var speed := 400
@export_range(0, 100) var health := 100:
	set = set_health

func set_health(val: int) -> void:
	health = clamp(val, 0, 100)

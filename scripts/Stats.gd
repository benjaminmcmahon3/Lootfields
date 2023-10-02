extends Resource
class_name Stats

@export var speed := 400:
	set = set_speed

@export_range(0, 100) var health := 100:
	set = set_health
	
@export var is_alive := true
	
@export var global_position: Vector2:
	set = set_global_position

func set_health(val: int) -> void:
	health = clamp(val, 0, 100)
	emit_changed()

func set_speed(val: int) -> void:
	speed = clamp(val, 0, 10000)
	emit_changed()
	
func set_global_position(val: Vector2) -> void:
	global_position = val
	emit_changed()
	
func take_damage(damage: int):
	set_health(health - damage)

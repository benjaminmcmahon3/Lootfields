extends Resource
class_name Stats

@export_category("Speed")
@export var speed: float = 400:
	set = set_speed
@export var max_speed: float

@export_category("Health")
@export var health: float = 100.0:
	set = set_health
@export var max_health: float
## How much health to regnerate each step
@export var health_regen_step := 1

@export_category("Mana")
@export var mana: float = 100.0:
	set = set_mana
@export var max_mana: float
## How much health to regnerate each step
@export var mana_regen_step: float = 2.0

@export var is_alive := true

@export var global_position: Vector2:
	set = set_global_position

func set_health(val: int) -> void:
	if max_health != 0:
		health = clamp(val, 0, max_health)
	else:
		health = val
	emit_changed()
	
func set_mana(val: int) -> void:
	if max_mana != 0:
		mana = clamp(val, 0, max_mana)
	else:
		mana = val
	emit_changed()

func set_speed(val: float) -> void:
	if max_speed != 0:
		speed = clamp(val, 0, max_speed)
	else:
		speed = val
	emit_changed()

func set_global_position(val: Vector2) -> void:
	global_position = val
	emit_changed()

func add_health(value: int):
	set_health(health + value)

func take_damage(damage: int):
	set_health(health - damage)

func add_mana(value: float):
	set_mana(mana + value)

func use_mana(value: float):
	set_mana(mana - value)

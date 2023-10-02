extends CharacterBody2D
class_name PlayerCharacter

signal player_tree_entered(player_scene)
signal player_damaged(amount)
signal player_death

@export var stats: Stats
@export var inventory: Inventory

@onready var ui_sprite := $AnimatedSprite2D
@onready var ui_player_menu := $PlayerMenu
@onready var ui_inventory := $PlayerMenu/Inventory

const fireball_scene = preload("res://Shootables/Fireball/Fireball.tscn")

func _ready():
	stats.global_position = global_position

func _physics_process(delta):
	stats.global_position = global_position

	var _velocity = Vector2.ZERO # The player's movement vector.

	if Input.is_action_pressed("move_up"):
		_velocity.y -= 1

	if Input.is_action_pressed("move_right"):
		_velocity.x += 1

	if Input.is_action_pressed("move_left"):
		_velocity.x -= 1

	if Input.is_action_pressed("move_down"):
		_velocity.y += 1

	if _velocity.length() > 0:
		_velocity = _velocity.normalized() * stats.speed

	self.velocity = _velocity
	position += velocity * delta

	if Input.is_action_just_pressed("shoot"):
		spawn_projectile()

	move_and_slide()

func _process(delta):
	if not velocity.length():
		ui_sprite.play("idle")
	elif velocity.x > 0:
		ui_sprite.play("walk_right")
	elif velocity.x < 0:
		ui_sprite.play("walk_left")
	elif velocity.y >= 0:
		ui_sprite.play("walk_down")
	elif velocity.y < 0:
		ui_sprite.play("walk_up")

	if Input.is_action_just_pressed("open_player_menu"):
		ui_player_menu.toggle_inventory()

func _enter_tree():
	emit_signal("player_tree_entered", self)
	
func take_damage(damage: int):
	stats.take_damage(damage)
	if stats.health == 0:
		death()

func death():
	ui_sprite.stop()
	var tween = create_tween()
	tween.tween_property(self, "rotation", deg_to_rad(90.0), 0.25)
	tween.tween_callback(Callable(death_tween_callback))
	
func death_tween_callback():
	emit_signal("player_death")
	process_mode = Node.PROCESS_MODE_DISABLED

func spawn_projectile():
	var fireball = fireball_scene.instantiate()
	self.add_child(fireball)

	var offset = (get_global_mouse_position() - self.position).normalized()
	fireball.apply_central_impulse(offset)
	fireball.look_at(get_global_mouse_position())
	fireball.add_collision_exception_with(self)
	var angle_to_mouse = get_angle_to(get_global_mouse_position())
	var direction = Vector2(cos(angle_to_mouse), sin(angle_to_mouse))

	fireball.global_position = self.position + Vector2(0, -5.0)
	fireball.linear_velocity = direction * fireball.projectileStats.speed

func _on_projectile_shape_entered(projectile: ProjectileStats):
	take_damage(projectile.damage)

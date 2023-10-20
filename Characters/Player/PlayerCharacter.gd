extends CharacterBody2D
class_name PlayerCharacter

signal player_tree_entered(player_scene)
signal player_damaged(amount)
signal player_death

@export var stats: Stats
@export var inventory: Inventory
@export var shoot_logic: ShootLogic

@onready var ui_sprite := $AnimatedSprite2D

const fireball_scene: Resource = preload("res://Shootables/Fireball.tscn")

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
		shoot()

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

func shoot():
	shoot_logic.spawn(
		self,
		fireball_scene,
		get_node("/root/Main/Worldspace"),
		self.position + (Vector2(0, -5.0)),
		(get_global_mouse_position() - self.position).normalized()
	)

func _on_projectile_shape_entered(projectile: ProjectileStats):
	take_damage(projectile.damage)

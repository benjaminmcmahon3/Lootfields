extends CharacterBody2D
class_name PlayerCharacter

signal player_tree_entered(player_scene)
signal player_damaged(amount)

@export var stats: Stats
@export var inventory: Inventory

@onready var ui_sprite := $AnimatedSprite2D
@onready var ui_player_menu := $PlayerMenu
@onready var ui_inventory := $PlayerMenu/Inventory

const fireball_scene = preload("res://Shootables/Fireball/Fireball.tscn")

func _ready():
	stats.global_position = global_position
	pass

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

	var hasCollided = get_last_slide_collision()
	if hasCollided:
		stats.health -= 5

		if (stats.health == 0):
			stats.health = 100

		print("Cannot go that way")

func _enter_tree():
	emit_signal("player_tree_entered", self)

func _on_body_entered(body):
	if body is TileMap:
		pass

func _on_damage_taken(damage_amount):
	emit_signal("player_damaged", damage_amount)

func spawn_projectile():
	var fireball = fireball_scene.instantiate()
	self.add_child(fireball)

	var offset = (get_global_mouse_position() - self.position).normalized()
	fireball.apply_central_impulse(offset)
	fireball.look_at(get_global_mouse_position())
	var angle_to_mouse = get_angle_to(get_global_mouse_position())
	var direction = Vector2(cos(angle_to_mouse), sin(angle_to_mouse))

	fireball.global_position = self.position + Vector2(0, -5.0)
	fireball.linear_velocity = direction * fireball.projectileStats.speed

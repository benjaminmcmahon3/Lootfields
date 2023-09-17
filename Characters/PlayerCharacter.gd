extends CharacterBody2D

signal player_tree_entered(player_scene)
signal player_damaged(amount)

@export var stats: Stats
@export var inventory: Inventory

@onready var ui_sprite := $AnimatedSprite2D
@onready var ui_player_menu := $PlayerMenu
@onready var ui_inventory := $PlayerMenu/Inventory

func _ready():
	pass

func _physics_process(delta):
	var velocity = Vector2.ZERO # The pawlayer's movement vector.
	var is_moving: bool

	if Input.is_action_pressed("move_up"):
		is_moving = true
		ui_sprite.play("walk_up")

	if Input.is_action_pressed("move_right"):
		is_moving = true
		ui_sprite.play("walk_right")

	if Input.is_action_pressed("move_left"):
		is_moving = true
		ui_sprite.play("walk_left")

	if Input.is_action_pressed("move_down"):
		is_moving = true
		ui_sprite.play("walk_down")

	if not is_moving:
		ui_sprite.play("idle")

	if is_moving:
		var mouse_position = get_global_mouse_position()
		var direction = (mouse_position - position).normalized()
		
		var dir_angle = direction.angle()
		if dir_angle < -0.75*PI and dir_angle > -0.25*PI:
			ui_sprite.play("walk_up")
		if dir_angle > -0.75*PI and dir_angle > 0.75*PI:
			ui_sprite.play("walk_left")
		if dir_angle < 0.75*PI and dir_angle > 0.25*PI:
			ui_sprite.play("walk_down")
		if dir_angle < 0.25*PI and dir_angle > -0.25*PI:
			ui_sprite.play("walk_right")
		
		velocity = direction * stats.speed
		

	position += velocity * delta
	
	var hasCollided = move_and_slide()
	if hasCollided:
		stats.health -= 5
		
		if (stats.health == 0):
			stats.health = 100
		
		print("Cannot go that way")

	if Input.is_action_just_pressed("open_player_menu"):
		ui_player_menu.toggle_inventory()

func _enter_tree():
	emit_signal("player_tree_entered", self)

func _on_body_entered(body):
	if body is TileMap:
		print("Cannot Go That Way")

func _on_damage_taken(damage_amount):
	emit_signal("player_damaged", damage_amount)

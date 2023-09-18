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
	var velocity = Vector2.ZERO # The player's movement vector.

	if Input.is_action_pressed("move_up"):
		velocity.y -= 1

	if Input.is_action_pressed("move_right"):
		velocity.x += 1

	if Input.is_action_pressed("move_left"):
		velocity.x -= 1

	if Input.is_action_pressed("move_down"):
		velocity.y += 1

	if velocity.length() > 0:
		velocity = velocity.normalized() * stats.speed

	self.velocity = velocity
	position += velocity * delta

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
		print("Cannot Go That Way")

func _on_damage_taken(damage_amount):
	emit_signal("player_damaged", damage_amount)
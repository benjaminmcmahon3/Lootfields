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

	if Input.is_action_pressed("move_right"):
		velocity.x += 1
		ui_sprite.play("walk_right")

	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
		ui_sprite.play("walk_left")

	if Input.is_action_pressed("move_down"):
		velocity.y += 1
		ui_sprite.play("walk_down")

	if Input.is_action_pressed("move_up"):
		velocity.y -= 1
		ui_sprite.play("walk_up")

	if velocity.x == 0 && velocity.y ==0:
		ui_sprite.play("idle")

	if velocity.length() > 0:
		velocity = velocity.normalized() * stats.speed

	position += velocity * delta

	var hasCollided = move_and_slide()
	if hasCollided:
		print("Cannot go that way")

	if Input.is_action_just_pressed("open_player_menu"):
		ui_player_menu.toggle_inventory()

func _enter_tree():
	emit_signal("player_tree_entered", self)

func _on_loot_taken(loot):
	loot.visible = false;
	inventory.add_item(loot)

func _on_body_entered(body):
	if body is TileMap:
		print("Cannot Go That Way")

func _on_damage_taken(damage_amount):
	emit_signal("player_damaged", damage_amount)

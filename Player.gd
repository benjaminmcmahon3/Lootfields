extends Area2D

class_name PlayerScene

signal player_tree_entered(player_scene)
signal player_picked_up_item(item)

@export var speed = 400
var screen_size # Size of the game window.

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var velocity = Vector2.ZERO # The pawlayer's movement vector.
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
	if Input.is_action_pressed("move_down"):
		velocity.y += 1
	if Input.is_action_pressed("move_up"):
		velocity.y -= 1

	if velocity.length() > 0:
		velocity = velocity.normalized() * speed

	position += velocity * delta
	position.x = clamp(position.x, 15, 3985)
	position.y = clamp(position.y, 15, 3985)

func _enter_tree():
	emit_signal("player_tree_entered", self)

func _on_loot_taken(loot):
	emit_signal("player_picked_up_item", loot)
	loot.visible = false;
	pass

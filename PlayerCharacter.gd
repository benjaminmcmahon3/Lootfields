extends CharacterBody2D

signal player_tree_entered(player_scene)
signal player_picked_up_item(item)

@export var speed = 400

func _physics_process(delta):
	var velocity = Vector2.ZERO # The pawlayer's movement vector.

	if Input.is_action_pressed("move_right"):
		velocity.x += 1
		$AnimatedSprite2D.play("walk_right")

	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
		$AnimatedSprite2D.play("walk_left")

	if Input.is_action_pressed("move_down"):
		velocity.y += 1
		$AnimatedSprite2D.play("walk_down")

	if Input.is_action_pressed("move_up"):
		velocity.y -= 1
		$AnimatedSprite2D.play("walk_up")

	if velocity.x == 0 && velocity.y ==0:
		$AnimatedSprite2D.play("idle")

	if velocity.length() > 0:
		velocity = velocity.normalized() * speed

	position += velocity * delta

	var hasCollided = move_and_slide()
	if hasCollided:
		print("Cannot go that way")

func _enter_tree():
	emit_signal("player_tree_entered", self)

func _on_loot_taken(loot):
	emit_signal("player_picked_up_item", loot)
	loot.visible = false;
	pass

func _on_body_entered(body):
	if body is TileMap:
		print("Cannot Go That Way")

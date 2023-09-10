extends Node2D

const loot_generator = preload("res://scripts/loot_generate.gd")

var player_ref

# Called when the node enters the scene tree for the first time.
func _ready():
	var x = $Forest/CollisionShape2D.position.x * 2
	var y = $Forest/CollisionShape2D.position.y * 2
	loot_generator.generate(self, player_ref, Vector2(x, y))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func _on_player_tree_entered(player):
	player_ref = player

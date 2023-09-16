extends Node2D

const loot_generator = preload("res://scripts/LootGenerate.gd")

#@export var loot_generation: LootGenerator

var player_ref

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
#	var x = $CollisionShape2D.position.x * 2
#	var y = $CollisionShape2D.position.y * 2
#	loot_generator.generate(self, player_ref, Vector2(x, y), "res://configuration/forest_loot.json")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func _on_player_tree_entered(player_scene):
	player_ref = player_scene

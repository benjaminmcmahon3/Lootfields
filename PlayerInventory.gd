extends Node2D

var inventory: InventoryManager

# Called when the node enters the scene tree for the first time.
func _ready():
	inventory = preload("res://scripts/InventoryManager.gd").new()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func _on_player_player_picked_up_item(item):
	inventory.add_item(item)


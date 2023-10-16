extends Node2D

func _ready():
	print("Worldspace ready! ", self)

func on_pause_game():
	get_tree().paused = true

func on_resume_game():
	get_tree().paused = false

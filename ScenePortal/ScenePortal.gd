extends Area2D

var scene_path

func _on_area_entered(area):
	print("Portal Entered")
	get_tree().change_scene_to_file(scene_path)

func set_scene_path(path):
	scene_path = path
